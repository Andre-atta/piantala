import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/room_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';
import 'package:uuid/uuid.dart';

class RoomRepositoryImpl implements IRoomRepository {
  RoomRepositoryImpl({Isar? isar}) : _isar = isar ?? IsarService.instance.db;

  final Isar _isar;
  final Uuid _uuid = const Uuid();

  @override
  Stream<List<RoomEntity>> watchRooms() {
    try {
      return _isar.roomCollections
          .where()
          .filter()
          .syncStatusIndexLessThan(SyncStatus.pendingDelete.index)
          .watch(fireImmediately: true)
          .map((collections) => collections.map((e) => e.toEntity()).toList())
          .asBroadcastStream();
    } catch (e) {
      throw LocalDatabaseException(
        'Errore durante la lettura delle stanze: $e',
      );
    }
  }

  @override
  Future<void> addRoom(RoomEntity room) async {
    try {
      final collection = room.toCollection()
        ..syncStatusIndex = SyncStatus.pendingCreate.index
        ..localUpdatedAt = DateTime.now();

      final pendingOp = PendingOperationCollection()
        ..operationId = _uuid.v4()
        ..userId = room.userId
        ..collectionPath = 'users/${room.userId}/rooms'
        ..documentId = room.id
        ..operation = 'create'
        ..payloadJson = jsonEncode(room.toJson())
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await _isar.writeTxn(() async {
        await _isar.roomCollections.put(collection);
        await _isar.pendingOperationCollections.put(pendingOp);
      });
    } catch (e) {
      throw LocalDatabaseException(
        "Errore durante l'aggiunta della stanza: $e",
      );
    }
  }

  @override
  Future<void> updateRoom(RoomEntity room) async {
    try {
      final existing = await _isar.roomCollections
          .where()
          .firestoreIdEqualTo(room.id)
          .findFirst();

      final collection = room.toCollection()
        ..id = existing?.id ?? Isar.autoIncrement
        ..syncStatusIndex = SyncStatus.pendingUpdate.index
        ..localUpdatedAt = DateTime.now();

      final pendingOp = PendingOperationCollection()
        ..operationId = _uuid.v4()
        ..userId = room.userId
        ..collectionPath = 'users/${room.userId}/rooms'
        ..documentId = room.id
        ..operation = 'update'
        ..payloadJson = jsonEncode(room.toJson())
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await _isar.writeTxn(() async {
        await _isar.roomCollections.put(collection);
        await _isar.pendingOperationCollections.put(pendingOp);
      });
    } catch (e) {
      throw LocalDatabaseException(
        "Errore durante l'aggiornamento della stanza: $e",
      );
    }
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    try {
      final existing = await _isar.roomCollections
          .where()
          .firestoreIdEqualTo(roomId)
          .findFirst();

      if (existing == null) return;

      existing
        ..syncStatusIndex = SyncStatus.pendingDelete.index
        ..localUpdatedAt = DateTime.now();

      final pendingOp = PendingOperationCollection()
        ..operationId = _uuid.v4()
        ..userId = existing.userId
        ..collectionPath = 'users/${existing.userId}/rooms'
        ..documentId = roomId
        ..operation = 'delete'
        ..payloadJson = '{}'
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await _isar.writeTxn(() async {
        await _isar.roomCollections.put(existing);
        await _isar.pendingOperationCollections.put(pendingOp);
      });
    } catch (e) {
      throw LocalDatabaseException(
        "Errore durante l'eliminazione della stanza: $e",
      );
    }
  }
}

// ── Extensions per Mapping Isar ↔ Domain ─────────────────────────────────────

extension _RoomEntityToCollection on RoomEntity {
  RoomCollection toCollection() {
    return RoomCollection()
      ..firestoreId = id
      ..userId = userId
      ..name = name
      ..exposure = exposure
      ..exposureConfirmedByUser = exposureConfirmedByUser
      ..floor = floor
      ..notes = notes
      ..createdAt = createdAt;
  }
}

extension _RoomCollectionToEntity on RoomCollection {
  RoomEntity toEntity() {
    return RoomEntity(
      id: firestoreId,
      userId: userId,
      name: name,
      exposure: exposure,
      exposureConfirmedByUser: exposureConfirmedByUser,
      floor: floor,
      notes: notes,
      createdAt: createdAt,
    );
  }
}
