import 'dart:async';
import 'package:piantala/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  /// Stream che emette l'utente corrente ogni volta che cambia lo
  /// stato di autenticazione.
  Stream<UserEntity?> get authStateChanges;

  /// Effettua il login usando Google Sign-In.
  Future<UserEntity?> signInWithGoogle();

  Future<UserEntity?> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<UserEntity?> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  );

  /// Invia una richiesta di reimpostazione della password.
  Future<void> sendPasswordResetEmail(String email);

  /// Effettua il logout.
  Future<void> signOut();

  /// Ottiene l'utente corrente, se presente.
  UserEntity? get currentUser;
}
