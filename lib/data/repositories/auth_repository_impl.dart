import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isar/isar.dart';

import 'package:piantala/core/constants/app_strings.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/domain/repositories/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
    Isar? isar,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
        _firestore = firestore,
        _functionsOverride = functions,
        _isar = isar;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore? _firestore;
  final FirebaseFunctions? _functionsOverride;
  final Isar? _isar;
  Future<void>? _init;

  Future<void> _ensureGoogleSignInInitialized() {
    final init = _init ??= _googleSignIn.initialize();
    return init.catchError((Object error, StackTrace stackTrace) {
      if (identical(_init, init)) {
        _init = null;
      }
      Error.throwWithStackTrace(error, stackTrace);
    });
  }

  FirebaseFunctions get _functions =>
      _functionsOverride ??
      FirebaseFunctions.instanceFor(region: 'europe-west1');

  Isar get _db => _isar ?? IsarService.instance.db;

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

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  AuthException _mapEmailAuthException(
    FirebaseAuthException error, {
    required bool isRegistration,
  }) {
    switch (error.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const AuthException(
          AppAuthStrings.errInvalidCredential,
          failure: AuthFailure.invalidCredential,
        );
      case 'invalid-email':
        return const AuthException(
          AppAuthStrings.errInvalidEmail,
          failure: AuthFailure.invalidEmail,
        );
      case 'weak-password':
        return const AuthException(
          AppAuthStrings.errWeakPassword,
          failure: AuthFailure.weakPassword,
        );
      case 'email-already-in-use':
        return const AuthException(
          AppAuthStrings.errEmailInUse,
          failure: AuthFailure.emailAlreadyInUse,
        );
      case 'user-disabled':
        return const AuthException(AppAuthStrings.errUserDisabled);
      case 'too-many-requests':
        return const AuthException(
          AppAuthStrings.errTooManyRequests,
          failure: AuthFailure.tooManyRequests,
        );
      case 'network-request-failed':
        return const AuthException(
          AppAuthStrings.errNetworkFailed,
          failure: AuthFailure.networkUnavailable,
        );
      case 'operation-not-allowed':
        return AuthException(
          isRegistration
              ? AppAuthStrings.errEmailProviderDisabledReg
              : AppAuthStrings.errEmailProviderDisabledLogin,
        );
      default:
        return AuthException(
          isRegistration
              ? AppAuthStrings.errRegistrationFallback
              : AppAuthStrings.errLoginFallback,
          failure: AuthFailure.generic,
        );
    }
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();
      final googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw const AuthException(AppAuthStrings.errGoogleSignIn);
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapGoogleAuthError(e));
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) return null;
      throw const AuthException(AppAuthStrings.errGoogleSignIn);
    } catch (_) {
      throw const AuthException(AppAuthStrings.errGoogleSignIn);
    }
  }

  @override
  Future<UserEntity?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail.isEmpty || password.isEmpty) {
      throw const AuthException(AppAuthStrings.errEmailRequired);
    }

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      return _mapFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw _mapEmailAuthException(e, isRegistration: false);
    }
  }

  @override
  Future<UserEntity?> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    final normalizedEmail = _normalizeEmail(email);
    final normalizedDisplayName = displayName.trim();
    if (normalizedEmail.isEmpty ||
        password.isEmpty ||
        normalizedDisplayName.isEmpty) {
      throw const AuthException(AppAuthStrings.errAllFieldsRequired);
    }

    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) return null;

      await user.updateDisplayName(normalizedDisplayName);
      await user.reload();
      final refreshedUser = _firebaseAuth.currentUser;

      await (_firestore ?? FirebaseFirestore.instance)
          .doc('users/${user.uid}')
          .set(
        {
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      return _mapFirebaseUser(refreshedUser ?? user);
    } on FirebaseAuthException catch (e) {
      throw _mapEmailAuthException(e, isRegistration: true);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail.isEmpty) {
      throw const AuthException(AppAuthStrings.errEmailRequiredForReset);
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: normalizedEmail);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'email-not-found') {
        throw const AuthException(
          AppAuthStrings.resetEmailSent,
          failure: AuthFailure.resetEmailSent,
        );
      }
      throw _mapEmailAuthException(e, isRegistration: false);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _ensureGoogleSignInInitialized();
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapGoogleAuthError(e));
    } on GoogleSignInException catch (e) {
      throw AuthException(
        e.description ?? AppAuthStrings.errLogout,
      );
    } catch (_) {
      throw const AuthException(AppAuthStrings.errLogout);
    }
  }

  String _mapGoogleAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'network-request-failed':
        return AppAuthStrings.errGoogleSignInNetwork;
      case 'user-disabled':
        return AppAuthStrings.errUserDisabled;
      case 'too-many-requests':
        return AppAuthStrings.errTooManyRequests;
      default:
        return AppAuthStrings.errAuthFallback;
    }
  }

  @override
  Future<UserEntity?> updateDisplayName(String displayName) async {
    final trimmed = displayName.trim();
    if (trimmed.isEmpty) {
      throw const AuthException(AppAuthStrings.errAllFieldsRequired);
    }
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    await user.updateDisplayName(trimmed);
    await user.reload();
    return _mapFirebaseUser(_firebaseAuth.currentUser ?? user);
  }

  @override
  Future<UserEntity?> updatePhotoUrl(String? photoUrl) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    await user.updatePhotoURL(photoUrl);
    await user.reload();
    return _mapFirebaseUser(_firebaseAuth.currentUser ?? user);
  }

  @override
  Future<void> deleteAccount() async {
    try {
      // 1. Invoca la Cloud Function che cancella Firestore e Storage lato server.
      final callable = _functions.httpsCallable('deleteMyAccount');
      await callable.call<dynamic>();

      // 2. Svuota il database locale Isar: rimuove piante, stanze, cache
      //    specie e operazioni pending per evitare dati orfani offline.
      await _db.writeTxn(() => _db.clear());

      // 3. Logout locale: invalida il token FirebaseAuth e il token GoogleSignIn.
      //    Questo fa scattare authStateChanges -> null, che GoRouter intercetta
      //    per reindirizzare automaticamente alla schermata di Login.
      await signOut();
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'failed-precondition' &&
          e.message == 'requires-recent-login') {
        throw const DeleteAccountException(
          'Per motivi di sicurezza, accedi nuovamente prima di eliminare il profilo.',
          requiresRecentLogin: true,
        );
      }
      throw DeleteAccountException(
        e.message ?? "Impossibile eliminare l'account. Riprova più tardi.",
      );
    } on DeleteAccountException {
      rethrow;
    } catch (_) {
      throw const DeleteAccountException(
        "Impossibile eliminare l'account. Riprova più tardi.",
      );
    }
  }
}
