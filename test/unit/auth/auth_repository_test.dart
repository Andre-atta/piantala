import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
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
