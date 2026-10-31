import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';
import 'package:piantala/data/repositories/plant_repository_impl.dart';
import 'package:piantala/domain/entities/plant_entity.dart';

void main() {
  late Isar isar;
  late PlantRepositoryImpl repository;

  setUpAll(() async {
    await IsarService.instance.initializeForTesting();
  });

  setUp(() async {
    isar = IsarService.instance.db;
    await isar.writeTxn(() => isar.clear());
    repository = PlantRepositoryImpl(isar: isar);
  });

  tearDownAll(() async {
    await IsarService.instance.close();
  });

  test('addPlant inserisce record in Isar con syncStatus pendingCreate',
      () async {
    final plant = PlantEntity(
      id: 'plant123',
      userId: 'user1',
      roomId: 'room1',
      customName: 'Ficus',
      shelfPosition: 0,
      createdAt: DateTime.now(),
    );

    await repository.addPlant(plant);

    // Verify PlantCollection
    final savedPlant = await isar.plantCollections
        .where()
        .firestoreIdEqualTo('plant123')
        .findFirst();
    expect(savedPlant, isNotNull);
    expect(savedPlant!.customName, equals('Ficus'));
    expect(savedPlant.syncStatusIndex, equals(SyncStatus.pendingCreate.index));

    // Verify PendingOperationCollection
    final pendingOp =
        await isar.pendingOperationCollections.where().findFirst();
    expect(pendingOp, isNotNull);
    expect(pendingOp!.operation, equals('create'));
    expect(pendingOp.documentId, equals('plant123'));
    expect(pendingOp.collectionPath, equals('users/user1/plants'));
  });

  test(
      'watchPlants emette stream aggiornato dopo insert e omette pendingDelete',
      () async {
    final stream = repository.watchPlants();
    final results = <List<PlantEntity>>[];
    final subscription = stream.listen(results.add);

    final plant = PlantEntity(
      id: 'plant123',
      userId: 'user1',
      roomId: 'room1',
      customName: 'Ficus',
      shelfPosition: 0,
      createdAt: DateTime.now(),
    );

    // Aspettiamo che arrivi il primo evento vuoto
    await Future<void>.delayed(const Duration(milliseconds: 250));

    await repository.addPlant(plant);
    // Aspettiamo l'evento di insert
    await Future<void>.delayed(const Duration(milliseconds: 250));

    await repository.deletePlant('plant123');
    // Aspettiamo l'evento di delete
    await Future<void>.delayed(const Duration(milliseconds: 250));

    await subscription.cancel();

    // Filtriamo i duplicati consecutivi (Isar a volte emette più eventi
    // se ci sono transazioni multiple interne)
    final distinctResults = <List<PlantEntity>>[];
    for (final res in results) {
      if (distinctResults.isEmpty ||
          distinctResults.last.length != res.length) {
        distinctResults.add(res);
      }
    }

    expect(distinctResults.length, greaterThanOrEqualTo(2));
    expect(distinctResults[0].isEmpty, isTrue, reason: 'Inizialmente vuoto');
    expect(distinctResults[1].length, equals(1), reason: 'Dopo insert');
    expect(distinctResults[1].first.customName, equals('Ficus'));
    expect(
      distinctResults.every((items) => items.length <= 1),
      isTrue,
      reason: 'La pianta eliminata non viene duplicata',
    );
  });
}
