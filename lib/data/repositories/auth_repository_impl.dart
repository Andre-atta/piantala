import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/domain/repositories/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserEntity? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Stream<UserEntity?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map(_mapFirebaseUser);

  @override
  UserEntity? get currentUser => _mapFirebaseUser(_firebaseAuth.currentUser);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // L'utente ha annullato il login
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        e.message ?? "Errore durante l'autenticazione Firebase",
      );
    } catch (e) {
      throw AuthException('Errore imprevisto durante il login con Google: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Errore durante il logout');
    } catch (e) {
      throw AuthException('Errore imprevisto durante il logout: $e');
    }
  }
}
