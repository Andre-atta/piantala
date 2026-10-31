import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/collections/plant_collection.dart';
import 'package:piantala/data/local/collections/room_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/local/sync_status.dart';
import 'package:piantala/data/repositories/opb_contribution_repository.dart';

class SyncService {
  @visibleForTesting
  SyncService({
    Isar? isar,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    OpbContributionRepository? opbContributionRepo,
  })  : _isar = isar ?? IsarService.instance.db,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _customAuth = auth,
        _customOpbContributionRepo = opbContributionRepo;

  SyncService._internal({
    Isar? isar,
    FirebaseFirestore? firestore,
  })  : _isar = isar ?? IsarService.instance.db,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _customAuth = null,
        _customOpbContributionRepo = null;

  static SyncService? _instance;

  // ignore: prefer_constructors_over_static_methods
  static SyncService get instance {
    _instance ??= SyncService._internal();
    return _instance!;
  }

  final Isar _isar;
  final FirebaseFirestore _firestore;
  final FirebaseAuth? _customAuth;
  final OpbContributionRepository? _customOpbContributionRepo;

  FirebaseAuth? get _auth {
    if (_customAuth != null) return _customAuth;
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      return null;
    }
  }

  OpbContributionRepository get _opbContributionRepo =>
      _customOpbContributionRepo ?? OpbContributionRepository();

  bool _isSyncing = false;

  // Subscriptions Firestore → Isar
  final List<StreamSubscription<dynamic>> _firestoreSubs = [];

  /// Ascolta in tempo reale le nuove PendingOperation e avvia il drain.
  /// Avvia anche i listener Firestore → Isar per la sincronizzazione
  /// bidirezionale (incluse modifiche/eliminazioni fatte fuori dall'app).
  void startListening() {
    _isar.pendingOperationCollections.watchLazy().listen((_) {
      _drainQueue();
    });
    // Avvia un drain iniziale al boot
    _drainQueue();

    final auth = _auth;
    if (auth != null) {
      // Avvia i listener Firestore → Isar dopo il login
      final uid = auth.currentUser?.uid;
      if (uid != null) {
        _startFirestoreListeners(uid);
      }

      // Quando l'utente si autentica (o cambia), aggiorna i listener
      auth.authStateChanges().listen((user) {
        _stopFirestoreListeners();
        if (user != null) {
          _startFirestoreListeners(user.uid);
        }
      });
    }
  }

  void _startFirestoreListeners(String uid) {
    _stopFirestoreListeners();

    // ── Listener piante ──────────────────────────────────────────────
    final plantsSub = _firestore
        .collection('users/$uid/plants')
        .snapshots()
        .listen((snapshot) async {
      await _applyFirestoreSnapshot(
        snapshot: snapshot,
        collectionType: _CollectionType.plants,
      );
    });

    // ── Listener stanze ──────────────────────────────────────────────
    final roomsSub = _firestore
        .collection('users/$uid/rooms')
        .snapshots()
        .listen((snapshot) async {
      await _applyFirestoreSnapshot(
        snapshot: snapshot,
        collectionType: _CollectionType.rooms,
      );
    });

    _firestoreSubs
      ..add(plantsSub)
      ..add(roomsSub);

    debugPrint('SyncService: Firestore listeners avviati per uid=$uid');

    // ── Migrazione one-shot per piante legacy ────────────────────────
    // Per piante create prima che cultivationMethod venisse
    // scritti su Firestore, forziamo un update dalla copia Isar locale.
    // L'operazione è idempotente: se la pending op esiste già, Isar la
    // sovrascrive senza duplicarla (stesso documentId).
    _migrateLegacyPlants(uid);
  }

  /// Forza la risincronizzazione delle piante locali verso Firestore.
  ///
  /// Eseguita una volta al login. Per ogni pianta Isar con `cultivationMethod`
  /// valorizzato, crea una pending op 'update' se non ne esiste già una.
  /// In questo modo i documenti Firestore legacy (senza cultivationMethod /
  /// i dati di coltura) vengono aggiornati al prossimo drain senza che l'utente
  /// debba intervenire.
  Future<void> _migrateLegacyPlants(String uid) async {
    try {
      final plants = await _isar.plantCollections.where().findAll();
      final now = DateTime.now();

      for (final plant in plants) {
        // Salta le piante senza cultivationMethod (niente da migrare)
        final method = plant.cultivationMethod;
        if (method == null || method == 'soil') continue;

        // Salta se c'è già una pending op per questo documento
        final hasPending = await _hasPendingOp(plant.firestoreId);
        if (hasPending) continue;

        // Crea il payload JSON letto direttamente da Isar.
        // Non usiamo toEntity().toJson() per evitare un import circolare
        // con plant_repository_impl.dart.
        // Il drain chiama docRef.set(payload, merge:true) → aggiorna solo i
        // campi presenti, non cancella gli altri.
        final payload = <String, dynamic>{
          'userId': plant.userId,
          'roomId': plant.roomId,
          'customName': plant.customName,
          'cultivationMethod': plant.cultivationMethod,
          if (plant.fertilizingConfig != null)
            'fertilizingConfig': {
              'frequencyDays': plant.fertilizingConfig!.frequencyDays,
              if (plant.fertilizingConfig!.lastFertilizedAt != null)
                'lastFertilizedAt': plant.fertilizingConfig!.lastFertilizedAt!
                    .toIso8601String(),
            },
        };

        final pendingOp = PendingOperationCollection()
          ..operationId = 'migration_${plant.firestoreId}'
          ..userId = uid
          ..collectionPath = 'users/$uid/plants'
          ..documentId = plant.firestoreId
          ..operation = 'update'
          ..payloadJson = jsonEncode(payload)
          ..createdAt = now
          ..attemptCount = 0;

        await _isar.writeTxn(() async {
          await _isar.pendingOperationCollections.put(pendingOp);
        });

        debugPrint(
          'SyncService: migrazione pianta legacy → Firestore: ${plant.customName} (${plant.firestoreId})',
        );
      }

      // Avvia un drain immediato per inviare le op di migrazione
      unawaited(_drainQueue());
    } catch (e) {
      debugPrint('SyncService _migrateLegacyPlants error: $e');
    }
  }

  void _stopFirestoreListeners() {
    for (final sub in _firestoreSubs) {
      sub.cancel();
    }
    _firestoreSubs.clear();
  }

  /// Applica lo snapshot Firestore su Isar, gestendo add/update/remove.
  Future<void> _applyFirestoreSnapshot({
    required QuerySnapshot<Map<String, dynamic>> snapshot,
    required _CollectionType collectionType,
  }) async {
    for (final change in snapshot.docChanges) {
      final docId = change.doc.id;

      try {
        switch (change.type) {
          case DocumentChangeType.added:
          case DocumentChangeType.modified:
            final data = change.doc.data();
            if (data == null) continue;
            await _upsertFromFirestore(
              docId: docId,
              data: data,
              collectionType: collectionType,
            );

          case DocumentChangeType.removed:
            await _removeFromIsar(
              docId: docId,
              collectionType: collectionType,
            );
        }
      } catch (e) {
        debugPrint(
          'SyncService _applyFirestoreSnapshot error ($collectionType): $e',
        );
      }
    }
  }

  Future<void> _upsertFromFirestore({
    required String docId,
    required Map<String, dynamic> data,
    required _CollectionType collectionType,
  }) async {
    await _isar.writeTxn(() async {
      switch (collectionType) {
        case _CollectionType.plants:
          // Controlla se abbiamo una pending op locale per questo doc
          // (se sì, Isar è la fonte di verità → non sovrascrivere)
          final hasPending = await _hasPendingOp(docId);
          if (hasPending) return;

          final existing = await _isar.plantCollections
              .where()
              .firestoreIdEqualTo(docId)
              .findFirst();

          final collection = _plantFromFirestore(
            data: data,
            firestoreId: docId,
            existingIsarId: existing?.id,
            existingLocal: existing,
          );
          await _isar.plantCollections.put(collection);

        case _CollectionType.rooms:
          final hasPending = await _hasPendingOp(docId);
          if (hasPending) return;

          final existing = await _isar.roomCollections
              .where()
              .firestoreIdEqualTo(docId)
              .findFirst();

          final collection = _roomFromFirestore(
            data: data,
            firestoreId: docId,
            existingIsarId: existing?.id,
          );
          await _isar.roomCollections.put(collection);
      }
    });
  }

  Future<void> _removeFromIsar({
    required String docId,
    required _CollectionType collectionType,
  }) async {
    await _isar.writeTxn(() async {
      switch (collectionType) {
        case _CollectionType.plants:
          await _isar.plantCollections
              .where()
              .firestoreIdEqualTo(docId)
              .deleteAll();
        case _CollectionType.rooms:
          await _isar.roomCollections
              .where()
              .firestoreIdEqualTo(docId)
              .deleteAll();
      }
    });
  }

  Future<bool> _hasPendingOp(String docId) async {
    final op = await _isar.pendingOperationCollections
        .filter()
        .documentIdEqualTo(docId)
        .findFirst();
    return op != null;
  }

  // ── Drain queue (Isar → Firestore) ──────────────────────────────────────

  Future<void> _drainQueue() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final operations = await _isar.pendingOperationCollections
          .where()
          .sortByCreatedAt()
          .findAll();

      for (final op in operations) {
        final success = await _processOperation(op);
        if (success) {
          await _markAsSyncedAndRemoveOp(op);
        } else {
          // In caso di fallimento su una operazione (es. offline o errore),
          // interrompiamo il drain per mantenere l'ordine FIFO
          // garantito da createdAt.
          break;
        }
      }
    } catch (e) {
      debugPrint('SyncService error during drainQueue: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _processOperation(PendingOperationCollection op) async {
    // ── Handler OPB (non usano Firestore, chiamano le callable) ──────────────
    if (op.operation == 'opb_contribute' || op.operation == 'opb_update') {
      return _processOpbOperation(op);
    }

    // ── Handler Firestore standard ───────────────────────────────────────────
    try {
      final docRef =
          _firestore.collection(op.collectionPath).doc(op.documentId);

      switch (op.operation) {
        case 'create':
        case 'update':
          final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;
          // Aggiungiamo updatedAt per la conflict resolution (last-write-wins)
          payload['updatedAt'] = FieldValue.serverTimestamp();

          await docRef.set(payload, SetOptions(merge: true));
          return true;

        case 'delete':
          await docRef.delete();
          return true;

        default:
          debugPrint('SyncService unknown operation: ${op.operation}');
          return true; // Rimuove l'operazione non valida dalla coda
      }
    } catch (e) {
      debugPrint('SyncService processOperation failed: $e');
      // Incrementa attemptCount per backoff (futura implementazione)
      await _isar.writeTxn(() async {
        op.attemptCount++;
        op.lastAttemptAt = DateTime.now();
        await _isar.pendingOperationCollections.put(op);
      });
      return false; // Firebase non raggiungibile o altro errore
    }
  }

  /// Esegue una operazione OPB dalla coda (opb_contribute | opb_update).
  ///
  /// Backoff esponenziale: attende 2^attemptCount minuti tra i tentativi,
  /// max 5 tentativi. Oltre → l'operazione viene rimossa (non può più riuscire
  /// senza intervento utente).
  Future<bool> _processOpbOperation(PendingOperationCollection op) async {
    const maxAttempts = 5;

    // Backoff: se non è il primo tentativo, verifica se è già trascorso il tempo.
    if (op.attemptCount > 0 && op.lastAttemptAt != null) {
      final waitMinutes =
          1 << op.attemptCount.clamp(0, 6); // 2, 4, 8, 16, 32, 64 min
      final nextAllowedAt =
          op.lastAttemptAt!.add(Duration(minutes: waitMinutes));
      if (DateTime.now().isBefore(nextAllowedAt)) {
        return false; // troppo presto — lascia in coda
      }
    }

    if (op.attemptCount >= maxAttempts) {
      debugPrint(
        'SyncService OPB op ${op.operationId} superato max tentativi — rimossa.',
      );
      return true; // ritorna true per far eliminare l'operazione dalla coda
    }

    final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;

    try {
      final Map<String, dynamic> response;
      if (op.operation == 'opb_contribute') {
        response = await _opbContributionRepo
            .executeContribute(payload)
            .then((r) => r.when(
                  success: (pid) => {'success': true, 'pid': pid},
                  alreadyExists: () => {'alreadyExists': true},
                  rateLimited: () => {'rateLimited': true},
                  validationError: (field, message) => {
                    'validationError': {'field': field, 'message': message}
                  },
                  quotaExceeded: () => {'quotaExceeded': true},
                  error: (msg) => {'error': msg},
                ));
      } else {
        final pid = payload['pid'] as String;
        final partial = Map<String, dynamic>.from(payload)..remove('pid');
        response = await _opbContributionRepo
            .executeUpdate(pid, partial)
            .then((r) => r.when(
                  success: (pid) => {'success': true, 'pid': pid},
                  alreadyExists: () => {'alreadyExists': true},
                  rateLimited: () => {'rateLimited': true},
                  validationError: (field, message) => {
                    'validationError': {'field': field, 'message': message}
                  },
                  quotaExceeded: () => {'quotaExceeded': true},
                  error: (msg) => {'error': msg},
                ));
      }

      // 409 / successo: rimuovi dalla coda.
      if (response['success'] == true || response['alreadyExists'] == true) {
        return true;
      }

      // 429 / quota: metti in backoff.
      if (response['rateLimited'] == true ||
          response['quotaExceeded'] == true) {
        await _isar.writeTxn(() async {
          op.attemptCount++;
          op.lastAttemptAt = DateTime.now();
          await _isar.pendingOperationCollections.put(op);
        });
        return false;
      }

      // Errore di validazione (400): non può essere risolta con retry.
      if (response['validationError'] != null) {
        debugPrint(
          'SyncService OPB validation error: ${response['validationError']}. '
          'Operazione rimossa dalla coda.',
        );
        return true;
      }

      // Errore generico: metti in backoff.
      debugPrint('SyncService OPB error: ${response['error']}');
      await _isar.writeTxn(() async {
        op.attemptCount++;
        op.lastAttemptAt = DateTime.now();
        await _isar.pendingOperationCollections.put(op);
      });
      return false;
    } catch (e) {
      debugPrint('SyncService _processOpbOperation exception: $e');
      await _isar.writeTxn(() async {
        op.attemptCount++;
        op.lastAttemptAt = DateTime.now();
        await _isar.pendingOperationCollections.put(op);
      });
      return false;
    }
  }

  Future<void> _markAsSyncedAndRemoveOp(PendingOperationCollection op) async {
    await _isar.writeTxn(() async {
      // 1. Elimina la pending operation
      await _isar.pendingOperationCollections.delete(op.id);

      // 2. Aggiorna lo stato nel collection originale in base al collectionPath
      if (op.operation == 'delete') {
        // Se è un delete, va rimosso definitivamente anche da Isar
        if (op.collectionPath.endsWith('/plants')) {
          await _isar.plantCollections
              .where()
              .firestoreIdEqualTo(op.documentId)
              .deleteAll();
        } else if (op.collectionPath.endsWith('/rooms')) {
          await _isar.roomCollections
              .where()
              .firestoreIdEqualTo(op.documentId)
              .deleteAll();
        }
      } else {
        // Create o update: marca come synced
        if (op.collectionPath.endsWith('/plants')) {
          final plant = await _isar.plantCollections
              .where()
              .firestoreIdEqualTo(op.documentId)
              .findFirst();
          if (plant != null) {
            plant.syncStatusIndex = SyncStatus.synced.index;
            await _isar.plantCollections.put(plant);
          }
        } else if (op.collectionPath.endsWith('/rooms')) {
          final room = await _isar.roomCollections
              .where()
              .firestoreIdEqualTo(op.documentId)
              .findFirst();
          if (room != null) {
            room.syncStatusIndex = SyncStatus.synced.index;
            await _isar.roomCollections.put(room);
          }
        }
      }
    });
  }

  // ── Builders Firestore → Isar collection ─────────────────────────────────

  PlantCollection _plantFromFirestore({
    required Map<String, dynamic> data,
    required String firestoreId,
    int? existingIsarId,
    // Record Isar esistente: usato come fallback per campi assenti su Firestore
    // (es. cultivationMethod su piante create prima del fix).
    PlantCollection? existingLocal,
  }) {
    WateringConfigIsar? wateringConfig;
    final wc = data['wateringConfig'] as Map<String, dynamic>?;
    if (wc != null) {
      wateringConfig = WateringConfigIsar()
        ..frequencyDays = (wc['frequencyDays'] as num?)?.toInt() ?? 7
        ..lastWateredAt = _parseDateTime(wc['lastWateredAt']);
    }

    CareConfigIsar? careConfig;
    final cc = data['careConfig'] as Map<String, dynamic>?;
    if (cc != null) {
      careConfig = CareConfigIsar()
        ..fertilizingFrequencyDays =
            (cc['fertilizingFrequencyDays'] as num?)?.toInt()
        ..lastFertilizedAt = _parseDateTime(cc['lastFertilizedAt'])
        ..lastRepottedAt = _parseDateTime(cc['lastRepottedAt']);
    }

    // FertilizingConfig: preferenza Firestore, poi record locale, poi null
    FertilizingConfigIsar? fertilizingConfig;
    final fc = data['fertilizingConfig'] as Map<String, dynamic>?;
    if (fc != null) {
      fertilizingConfig = FertilizingConfigIsar()
        ..frequencyDays = (fc['frequencyDays'] as num?)?.toInt() ?? 30
        ..lastFertilizedAt = _parseDateTime(fc['lastFertilizedAt']);
    } else {
      // Campo non presente su Firestore → preserva valore Isar locale
      fertilizingConfig = existingLocal?.fertilizingConfig;
    }

    // cultivationMethod: preferenza Firestore, poi record locale, poi 'soil'
    final cultivationMethod = data['cultivationMethod'] as String? ??
        existingLocal?.cultivationMethod ??
        'soil';

    final col = PlantCollection()
      ..id = existingIsarId ?? Isar.autoIncrement
      ..firestoreId = firestoreId
      ..userId = data['userId'] as String? ?? ''
      ..roomId = data['roomId'] as String? ?? 'unassigned'
      ..customName = data['customName'] as String? ?? ''
      ..speciesApiId = data['speciesApiId'] as String?
      ..speciesCommonName = data['speciesCommonName'] as String?
      ..speciesScientificName = data['speciesScientificName'] as String?
      ..photoUrl = data['photoUrl'] as String?
      ..thumbnailUrl = data['thumbnailUrl'] as String?
      ..shelfPosition = (data['shelfPosition'] as num?)?.toInt() ?? 0
      ..isArchived = data['isArchived'] as bool? ?? false
      ..notes = data['notes'] as String?
      ..tags =
          (data['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              []
      ..acquisitionDate = _parseDateTime(data['acquisitionDate'])
      ..createdAt = _parseDateTime(data['createdAt']) ?? DateTime.now()
      ..wateringConfig = wateringConfig
      ..careConfig = careConfig
      ..fertilizingConfig = fertilizingConfig
      ..cultivationMethod = cultivationMethod
      ..localUpdatedAt = DateTime.now()
      ..syncStatusIndex = SyncStatus.synced.index;

    return col;
  }

  RoomCollection _roomFromFirestore({
    required Map<String, dynamic> data,
    required String firestoreId,
    int? existingIsarId,
  }) {
    return RoomCollection()
      ..id = existingIsarId ?? Isar.autoIncrement
      ..firestoreId = firestoreId
      ..userId = data['userId'] as String? ?? ''
      ..name = data['name'] as String? ?? ''
      ..exposure = data['exposure'] as String? ?? 'UNKNOWN'
      ..exposureConfirmedByUser =
          data['exposureConfirmedByUser'] as bool? ?? false
      ..floor = (data['floor'] as num?)?.toInt()
      ..notes = data['notes'] as String?
      ..createdAt = _parseDateTime(data['createdAt']) ?? DateTime.now()
      ..localUpdatedAt = DateTime.now()
      ..syncStatusIndex = SyncStatus.synced.index;
  }

  DateTime? _parseDateTime(dynamic val) {
    if (val is Timestamp) return val.toDate();
    if (val is String) return DateTime.tryParse(val);
    return null;
  }
}

enum _CollectionType { plants, rooms }
