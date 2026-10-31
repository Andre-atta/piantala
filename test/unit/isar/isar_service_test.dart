import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/collections/room_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';

void main() {
  late Isar isar;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    isar = await Isar.open(
      [
        PlantCollectionSchema,
        RoomCollectionSchema,
        PendingOperationCollectionSchema,
      ],
      directory: '',
      name: 'test_${DateTime.now().millisecondsSinceEpoch}',
    );
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  group('IsarService', () {
    test('initializeForTesting apre il DB senza crash', () async {
      final svc = IsarService.instance;
      await svc.initializeForTesting();
      expect(svc.db, isNotNull);
      await svc.close();
    });
  });

  group('PendingOperationCollection CRUD', () {
    test("insert e read di un'operazione pending", () async {
      final op = PendingOperationCollection()
        ..operationId = 'op-uuid-001'
        ..userId = 'user-123'
        ..collectionPath = 'users/user-123/plants'
        ..documentId = 'plant-abc'
        ..operation = 'create'
        ..payloadJson = '{"customName":"Monstera"}'
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await isar.writeTxn(() async {
        await isar.pendingOperationCollections.put(op);
      });

      final result = await isar.pendingOperationCollections
          .filter()
          .operationIdEqualTo('op-uuid-001')
          .findFirst();

      expect(result, isNotNull);
      expect(result!.userId, 'user-123');
      expect(result.operation, 'create');
      expect(result.attemptCount, 0);
    });

    test("increment di attemptCount su un'operazione esistente", () async {
      final op = PendingOperationCollection()
        ..operationId = 'op-uuid-002'
        ..userId = 'user-123'
        ..collectionPath = 'users/user-123/plants'
        ..documentId = 'plant-def'
        ..operation = 'update'
        ..payloadJson = '{"customName":"Ficus"}'
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await isar.writeTxn(() async {
        await isar.pendingOperationCollections.put(op);
      });

      // Aggiorna attemptCount
      await isar.writeTxn(() async {
        final existing = await isar.pendingOperationCollections
            .filter()
            .operationIdEqualTo('op-uuid-002')
            .findFirst();
        existing!
          ..attemptCount = 1
          ..lastAttemptAt = DateTime.now();
        await isar.pendingOperationCollections.put(existing);
      });

      final updated = await isar.pendingOperationCollections
          .filter()
          .operationIdEqualTo('op-uuid-002')
          .findFirst();

      expect(updated!.attemptCount, 1);
      expect(updated.lastAttemptAt, isNotNull);
    });

    test("delete di un'operazione dopo sync", () async {
      final op = PendingOperationCollection()
        ..operationId = 'op-uuid-003'
        ..userId = 'user-123'
        ..collectionPath = 'users/user-123/plants'
        ..documentId = 'plant-ghi'
        ..operation = 'delete'
        ..payloadJson = '{}'
        ..createdAt = DateTime.now()
        ..attemptCount = 0;

      await isar.writeTxn(() async {
        await isar.pendingOperationCollections.put(op);
      });

      final before = await isar.pendingOperationCollections.count();
      expect(before, 1);

      await isar.writeTxn(() async {
        await isar.pendingOperationCollections
            .filter()
            .operationIdEqualTo('op-uuid-003')
            .deleteAll();
      });

      final after = await isar.pendingOperationCollections.count();
      expect(after, 0);
    });
  });

  group('PlantCollection', () {
    test('insert una pianta con syncStatus=pendingCreate', () async {
      final plant = PlantCollection()
        ..firestoreId = 'plant-firestore-001'
        ..userId = 'user-123'
        ..syncStatusIndex = SyncStatus.pendingCreate.index
        ..localUpdatedAt = DateTime.now()
        ..roomId = 'room-001'
        ..customName = 'Monstera Deliciosa'
        ..shelfPosition = 0
        ..isArchived = false
        ..tags = []
        ..createdAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.plantCollections.put(plant);
      });

      final result = await isar.plantCollections
          .filter()
          .firestoreIdEqualTo('plant-firestore-001')
          .findFirst();

      expect(result, isNotNull);
      expect(result!.customName, 'Monstera Deliciosa');
      expect(result.syncStatusIndex, SyncStatus.pendingCreate.index);
    });
  });

  group('RoomCollection', () {
    test('insert una stanza', () async {
      final room = RoomCollection()
        ..firestoreId = 'room-firestore-001'
        ..userId = 'user-123'
        ..syncStatusIndex = SyncStatus.synced.index
        ..localUpdatedAt = DateTime.now()
        ..name = 'Soggiorno'
        ..exposure = 'SE'
        ..exposureConfirmedByUser = false
        ..createdAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.roomCollections.put(room);
      });

      final result = await isar.roomCollections
          .filter()
          .nameEqualTo('Soggiorno')
          .findFirst();

      expect(result, isNotNull);
      expect(result!.exposure, 'SE');
    });
  });
}
