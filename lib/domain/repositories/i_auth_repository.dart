import 'dart:async';
import 'package:piantala/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  /// Stream che emette l'utente corrente ogni volta che cambia lo
  /// stato di autenticazione.
  Stream<UserEntity?> get authStateChanges;

  /// Effettua il login usando Google Sign-In.
  Future<UserEntity?> signInWithGoogle();

  /// Effettua il logout.
  Future<void> signOut();

  /// Ottiene l'utente corrente, se presente.
  UserEntity? get currentUser;
}
