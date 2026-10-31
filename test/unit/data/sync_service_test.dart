import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';
import 'package:piantala/data/services/sync_service.dart';

void main() {
  late Isar isar;
  late FakeFirebaseFirestore fakeFirestore;
  late SyncService syncService;

  setUpAll(() async {
    await IsarService.instance.initializeForTesting();
  });

  setUp(() async {
    isar = IsarService.instance.db;
    await isar.writeTxn(() => isar.clear());
    fakeFirestore = FakeFirebaseFirestore();
    syncService = SyncService(
      isar: isar,
      firestore: fakeFirestore,
    );
  });

  tearDownAll(() async {
    await IsarService.instance.close();
  });

  test('SyncService processa pending_create e lo manda a Firestore', () async {
    // Prepariamo record locale in Isar
    final plant = PlantCollection()
      ..firestoreId = 'doc123'
      ..userId = 'user1'
      ..roomId = 'room1'
      ..customName = 'Ficus'
      ..shelfPosition = 0
      ..isArchived = false
      ..tags = []
      ..createdAt = DateTime.now()
      ..syncStatusIndex = SyncStatus.pendingCreate.index
      ..localUpdatedAt = DateTime.now();

    final op = PendingOperationCollection()
      ..operationId = 'op123'
      ..userId = 'user1'
      ..collectionPath = 'users/user1/plants'
      ..documentId = 'doc123'
      ..operation = 'create'
      ..payloadJson = '{"customName": "Ficus"}'
      ..createdAt = DateTime.now()
      ..attemptCount = 0;

    await isar.writeTxn(() async {
      await isar.plantCollections.put(plant);
      await isar.pendingOperationCollections.put(op);
    });

    // Avviamo listen
    syncService.startListening();

    // Aspettiamo che il sync completi facendo polling sulla coda
    for (var i = 0; i < 20; i++) {
      final count = await isar.pendingOperationCollections.count();
      if (count == 0) break;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }

    // Verifichiamo Firestore
    final doc = await fakeFirestore
        .collection('users/user1/plants')
        .doc('doc123')
        .get();
    expect(doc.exists, isTrue);
    expect(doc.data()!['customName'], equals('Ficus'));
    expect(doc.data()!['updatedAt'], isNotNull);

    PlantCollection? savedPlant;
    for (var i = 0; i < 10; i++) {
      savedPlant = await isar.plantCollections
          .where()
          .firestoreIdEqualTo('doc123')
          .findFirst();
      if (savedPlant?.syncStatusIndex == SyncStatus.synced.index) break;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    expect(savedPlant!.syncStatusIndex, equals(SyncStatus.synced.index));
  });

  test('Al ritorno online queue svuotata in ordine FIFO', () async {
    // Mettiamo 2 operazioni, simulate con FakeFirestore che funziona
    // normalmente
    final op1 = PendingOperationCollection()
      ..operationId = 'op1'
      ..userId = 'user1'
      ..collectionPath = 'users/user1/plants'
      ..documentId = 'doc1'
      ..operation = 'create'
      ..payloadJson = '{"name": "Pianta 1"}'
      ..createdAt = DateTime.now().subtract(const Duration(minutes: 1))
      ..attemptCount = 0;

    final op2 = PendingOperationCollection()
      ..operationId = 'op2'
      ..userId = 'user1'
      ..collectionPath = 'users/user1/plants'
      ..documentId = 'doc1'
      ..operation = 'update'
      ..payloadJson = '{"name": "Pianta Modificata"}'
      ..createdAt = DateTime.now()
      ..attemptCount = 0;

    await isar.writeTxn(() async {
      await isar.pendingOperationCollections
          .putAll([op2, op1]); // inseriti disordinati
    });

    syncService.startListening();
    for (var i = 0; i < 20; i++) {
      final count = await isar.pendingOperationCollections.count();
      if (count == 0) break;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }

    final doc =
        await fakeFirestore.collection('users/user1/plants').doc('doc1').get();
    expect(doc.exists, isTrue);
    // Deve finire col payload di op2, perché FIFO processerà prima op1 poi op2
    expect(doc.data()!['name'], equals('Pianta Modificata'));

  });
}
