/// Gerarchia di eccezioni di Piantala.
/// REGOLA: ogni catch in repository o service deve rilanciare
/// come AppException, mai come Exception raw.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => message;
}

// ── Rete / Connettività ──────────────────────────────────────────────────────
final class NetworkUnavailableException extends AppException {
  const NetworkUnavailableException()
      : super(
          'Nessuna connessione disponibile. '
          'I dati saranno sincronizzati al ritorno online.',
        );
}

// ── Firestore ────────────────────────────────────────────────────────────────
final class FirestoreException extends AppException {
  const FirestoreException(super.message);
}

// ── Auth ─────────────────────────────────────────────────────────────────────
final class AuthException extends AppException {
  const AuthException(super.message);
}

final class UserNotFoundException extends AppException {
  const UserNotFoundException()
      : super('Utente non trovato. Prova a effettuare nuovamente il login.');
}

// ── Enciclopedia (Perenual) ──────────────────────────────────────────────────
final class EncyclopediaApiException extends AppException {
  const EncyclopediaApiException(super.message);
}

// ── Permessi ─────────────────────────────────────────────────────────────────
final class PermissionDeniedException extends AppException {
  const PermissionDeniedException(String permission)
      : super(
          'Permesso $permission negato. '
          'Abilitalo nelle impostazioni del dispositivo.',
        );
}

// ── Storage (Firebase Storage) ───────────────────────────────────────────────
final class StorageUploadException extends AppException {
  const StorageUploadException(super.message);
}

// ── Isar (database locale) ───────────────────────────────────────────────────
final class LocalDatabaseException extends AppException {
  const LocalDatabaseException(super.message);
}
