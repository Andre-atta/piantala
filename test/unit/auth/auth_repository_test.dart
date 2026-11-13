import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/data/repositories/auth_repository_impl.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    repository = AuthRepositoryImpl(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
  });

  group('AuthRepositoryImpl', () {
    test('maps missing user and wrong password to one neutral failure',
        () async {
      for (final code in [
        'user-not-found',
        'wrong-password',
        'invalid-credential',
      ]) {
        final firebaseAuth = MockFirebaseAuth();
        final emailRepository = AuthRepositoryImpl(
          firebaseAuth: firebaseAuth,
          googleSignIn: MockGoogleSignIn(),
        );
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: 'person@example.com',
            password: 'secret1',
          ),
        ).thenThrow(FirebaseAuthException(code: code));

        await expectLater(
          emailRepository.signInWithEmailAndPassword(
            'person@example.com',
            'secret1',
          ),
          throwsA(
            isA<AuthException>().having(
              (error) => error.failure,
              'failure',
              AuthFailure.invalidCredential,
            ),
          ),
        );
      }
    });

    test('maps registration failures to their stable categories', () async {
      for (final (code, failure) in [
        ('email-already-in-use', AuthFailure.emailAlreadyInUse),
        ('weak-password', AuthFailure.weakPassword),
      ]) {
        final firebaseAuth = MockFirebaseAuth();
        final emailRepository = AuthRepositoryImpl(
          firebaseAuth: firebaseAuth,
          googleSignIn: MockGoogleSignIn(),
        );
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: 'person@example.com',
            password: 'secret1',
          ),
        ).thenThrow(FirebaseAuthException(code: code));

        await expectLater(
          emailRepository.createUserWithEmailAndPassword(
            'person@example.com',
            'secret1',
            'Plant Friend',
          ),
          throwsA(
            isA<AuthException>().having(
              (error) => error.failure,
              'failure',
              failure,
            ),
          ),
        );
      }
    });

    test('maps Firebase network and rate limit failures for reset', () async {
      for (final (code, failure) in [
        ('network-request-failed', AuthFailure.networkUnavailable),
        ('too-many-requests', AuthFailure.tooManyRequests),
      ]) {
        final firebaseAuth = MockFirebaseAuth();
        final emailRepository = AuthRepositoryImpl(
          firebaseAuth: firebaseAuth,
          googleSignIn: MockGoogleSignIn(),
        );
        when(
          () => firebaseAuth.sendPasswordResetEmail(
            email: 'person@example.com',
          ),
        ).thenThrow(FirebaseAuthException(code: code));

        await expectLater(
          emailRepository.sendPasswordResetEmail('person@example.com'),
          throwsA(
            isA<AuthException>().having(
              (error) => error.failure,
              'failure',
              failure,
            ),
          ),
        );
      }
    });

    test('keeps password reset response neutral for unknown accounts',
        () async {
      final firebaseAuth = MockFirebaseAuth();
      final emailRepository = AuthRepositoryImpl(
        firebaseAuth: firebaseAuth,
        googleSignIn: MockGoogleSignIn(),
      );
      when(
        () => firebaseAuth.sendPasswordResetEmail(email: 'person@example.com'),
      ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      await expectLater(
        emailRepository.sendPasswordResetEmail('person@example.com'),
        throwsA(
          isA<AuthException>().having(
            (error) => error.failure,
            'failure',
            AuthFailure.resetEmailSent,
          ),
        ),
      );
    });

    test("signInWithGoogle restituisce null se l'utente annulla", () async {
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      final result = await repository.signInWithGoogle();

      expect(result, isNull);
      verify(() => mockGoogleSignIn.signIn()).called(1);
    });

    test('signOut chiama sia FirebaseAuth che GoogleSignIn signOut', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});
      when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => null);

      await repository.signOut();

      verify(() => mockFirebaseAuth.signOut()).called(1);
      verify(() => mockGoogleSignIn.signOut()).called(1);
    });
  });
}
