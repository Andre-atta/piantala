import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:isar/isar.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/repositories/i_plant_repository.dart';
import 'package:uuid/uuid.dart';

class PlantRepositoryImpl implements IPlantRepository {
  PlantRepositoryImpl({Isar? isar}) : _isar = isar ?? IsarService.instance.db;
  final Isar _isar;
  final Uuid _uuid = const Uuid();

  @override
  Stream<List<PlantEntity>> watchPlants() => _isar.plantCollections
      .where()
      .filter()
      .syncStatusIndexLessThan(SyncStatus.pendingDelete.index)
      .watch(fireImmediately: true)
      .map((items) => items.map((item) => item.toEntity()).toList())
      .asBroadcastStream();

  @override
  Stream<PlantEntity?> watchPlant(String plantId) => _isar.plantCollections
      .where()
      .firestoreIdEqualTo(plantId)
      .watch(fireImmediately: true)
      .map((items) => items.isEmpty ? null : items.first.toEntity())
      .asBroadcastStream();

  @override
  Future<void> addPlant(PlantEntity plant) async {
    try {
      final collection = plant.toCollection()
        ..syncStatusIndex = SyncStatus.pendingCreate.index
        ..localUpdatedAt = DateTime.now();
      await _isar.writeTxn(() async {
        await _isar.plantCollections.put(collection);
        await _isar.pendingOperationCollections.put(_pending(plant, 'create'));
      });
    } catch (error) {
      throw LocalDatabaseException(
          "Errore durante l'aggiunta della pianta: $error");
    }
  }

  @override
  Future<void> updatePlant(PlantEntity plant) async {
    try {
      final existing = await _isar.plantCollections
          .where()
          .firestoreIdEqualTo(plant.id)
          .findFirst();
      if (existing == null) return;
      if (existing.photoUrl != null &&
          existing.photoUrl != plant.photoUrl &&
          existing.photoUrl!.startsWith('https://firebasestorage')) {
        FirebaseStorage.instance
            .refFromURL(existing.photoUrl!)
            .delete()
            .ignore();
      }
      final collection = plant.toCollection()
        ..id = existing.id
        ..syncStatusIndex = SyncStatus.pendingUpdate.index
        ..localUpdatedAt = DateTime.now();
      await _isar.writeTxn(() async {
        await _isar.plantCollections.put(collection);
        await _isar.pendingOperationCollections.put(_pending(plant, 'update'));
      });
    } catch (error) {
      throw LocalDatabaseException(
        "Errore durante l'aggiornamento della pianta: $error",
      );
    }
  }

  PendingOperationCollection _pending(PlantEntity plant, String operation) =>
      PendingOperationCollection()
        ..operationId = _uuid.v4()
        ..userId = plant.userId
        ..collectionPath = 'users/${plant.userId}/plants'
        ..documentId = plant.id
        ..operation = operation
        ..payloadJson = jsonEncode(plant.toJson())
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

  @override
  Future<void> deletePlant(String plantId) async {
    final existing = await _isar.plantCollections
        .where()
        .firestoreIdEqualTo(plantId)
        .findFirst();
    if (existing == null) return;
    if (existing.photoUrl?.startsWith('https://firebasestorage') ?? false) {
      FirebaseStorage.instance.refFromURL(existing.photoUrl!).delete().ignore();
    }
    existing
      ..syncStatusIndex = SyncStatus.pendingDelete.index
      ..localUpdatedAt = DateTime.now();
    final pending = PendingOperationCollection()
      ..operationId = _uuid.v4()
      ..userId = existing.userId
      ..collectionPath = 'users/${existing.userId}/plants'
      ..documentId = plantId
      ..operation = 'delete'
      ..payloadJson = '{}'
      ..createdAt = DateTime.now()
      ..attemptCount = 0;
    await _isar.writeTxn(() async {
      await _isar.plantCollections.put(existing);
      await _isar.pendingOperationCollections.put(pending);
    });
  }
}

extension on PlantEntity {
  PlantCollection toCollection() => PlantCollection()
    ..firestoreId = id
    ..userId = userId
    ..roomId = roomId
    ..speciesApiId = speciesApiId
    ..customName = customName
    ..speciesCommonName = speciesCommonName
    ..speciesScientificName = speciesScientificName
    ..photoUrl = photoUrl
    ..thumbnailUrl = thumbnailUrl
    ..shelfPosition = shelfPosition
    ..wateringConfig = wateringConfig?.toIsar()
    ..careConfig = careConfig?.toIsar()
    ..fertilizingConfig = fertilizingConfig?.toIsar()
    ..cultivationMethod = cultivationMethod
    ..acquisitionDate = acquisitionDate
    ..notes = notes
    ..tags = tags
    ..isArchived = isArchived
    ..createdAt = createdAt;
}

extension on WateringConfigEntity {
  WateringConfigIsar toIsar() => WateringConfigIsar()
    ..frequencyDays = frequencyDays
    ..lastWateredAt = lastWateredAt;
}

extension on CareConfigEntity {
  CareConfigIsar toIsar() => CareConfigIsar()
    ..fertilizingFrequencyDays = fertilizingFrequencyDays
    ..lastFertilizedAt = lastFertilizedAt
    ..lastRepottedAt = lastRepottedAt;
}

extension on FertilizingConfigEntity {
  FertilizingConfigIsar toIsar() => FertilizingConfigIsar()
    ..frequencyDays = frequencyDays
    ..lastFertilizedAt = lastFertilizedAt;
}

extension on PlantCollection {
  PlantEntity toEntity() => PlantEntity(
        id: firestoreId,
        userId: userId,
        roomId: roomId,
        speciesApiId: speciesApiId,
        customName: customName,
        speciesCommonName: speciesCommonName,
        speciesScientificName: speciesScientificName,
        photoUrl: photoUrl,
        thumbnailUrl: thumbnailUrl,
        shelfPosition: shelfPosition,
        wateringConfig: wateringConfig?.toEntity(),
        careConfig: careConfig?.toEntity(),
        fertilizingConfig: fertilizingConfig?.toEntity(),
        cultivationMethod: cultivationMethod ?? 'soil',
        acquisitionDate: acquisitionDate,
        notes: notes,
        tags: tags,
        isArchived: isArchived,
        createdAt: createdAt,
      );
}

extension on WateringConfigIsar {
  WateringConfigEntity toEntity() => WateringConfigEntity(
        frequencyDays: frequencyDays,
        lastWateredAt: lastWateredAt,
      );
}

extension on CareConfigIsar {
  CareConfigEntity toEntity() => CareConfigEntity(
        fertilizingFrequencyDays: fertilizingFrequencyDays,
        lastFertilizedAt: lastFertilizedAt,
        lastRepottedAt: lastRepottedAt,
      );
}

extension on FertilizingConfigIsar {
  FertilizingConfigEntity toEntity() => FertilizingConfigEntity(
        frequencyDays: frequencyDays,
        lastFertilizedAt: lastFertilizedAt,
      );
}
