/// Status di sincronizzazione Isar ↔ Firestore.
/// Ogni collection Isar deve avere un campo `syncStatusIndex`
/// che usa questo enum.
enum SyncStatus {
  synced, // 0 — allineato con Firestore
  pendingCreate, // 1 — da creare su Firestore
  pendingUpdate, // 2 — da aggiornare su Firestore
  pendingDelete, // 3 — da eliminare da Firestore
}
