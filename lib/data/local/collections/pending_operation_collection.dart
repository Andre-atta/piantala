import 'package:isar/isar.dart';
import 'package:piantala/data/local/sync_status.dart';

part 'pending_operation_collection.g.dart';

/// Coda operazioni offline da sincronizzare su Firestore.
/// Ogni write dell'utente viene accodata qui prima di essere inviata.
@collection
class PendingOperationCollection {
  Id id = Isar.autoIncrement;

  /// UUID univoco dell'operazione
  @Index(unique: true)
  late String operationId;

  /// UID dell'utente proprietario
  @Index()
  late String userId;

  /// Path completo del documento Firestore, es. "users/uid/plants/plantId"
  late String collectionPath;

  /// ID del documento Firestore
  late String documentId;

  /// Tipo di operazione: create | update | delete
  late String operation;

  /// Payload JSON serializzato del documento
  late String payloadJson;

  /// Quando l'operazione è stata accodata
  late DateTime createdAt;

  /// Numero di tentativi (per backoff esponenziale)
  late int attemptCount;

  /// Ultimo tentativo effettuato
  DateTime? lastAttemptAt;

  // ── Campo obbligatorio sync (per consistenza con le altre collection) ──
  int get syncStatusIndex => SyncStatus.pendingCreate.index;
}
