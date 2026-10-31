import 'package:isar/isar.dart';

part 'room_collection.g.dart';

/// Schema Isar per le stanze — mirror di `users/{uid}/rooms/{roomId}` Firestore.
@collection
class RoomCollection {
  Id id = Isar.autoIncrement;

  // ── Campi di sincronizzazione obbligatori ─────────────────────────────
  @Index(unique: true)
  late String firestoreId;

  @Index()
  late String userId;

  /// 0=synced, 1=pendingCreate, 2=pendingUpdate, 3=pendingDelete
  late int syncStatusIndex;

  late DateTime localUpdatedAt;

  // ── Campi business ────────────────────────────────────────────────────
  late String name;

  /// N | NE | E | SE | S | SW | W | NW | UNKNOWN
  late String exposure;

  late bool exposureConfirmedByUser;
  int? floor;
  String? notes;
  late DateTime createdAt;
}
