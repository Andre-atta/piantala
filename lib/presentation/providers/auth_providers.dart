import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piantala/data/repositories/auth_repository_impl.dart';
import 'package:piantala/data/services/fcm_service.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/domain/repositories/i_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(firestore: FirebaseFirestore.instance);
}

@Riverpod(keepAlive: true)
Stream<UserEntity?> authState(AuthStateRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

@Riverpod(keepAlive: true)
UserEntity? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.valueOrNull;
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signInWithGoogle();
    });
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signInWithEmailAndPassword(email, password);
    });
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.createUserWithEmailAndPassword(
        email,
        password,
        displayName,
      );
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.sendPasswordResetEmail(email);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Rimuove il token FCM prima del logout (serve essere autenticati).
      // Con timeout: se offline il logout avviene comunque.
      await FcmService.instance
          .clearForSignOut()
          .timeout(const Duration(seconds: 3))
          .catchError((_) {}); // timeout ignorato
      final repository = ref.read(authRepositoryProvider);
      await repository.signOut();
    });
  }

  Future<void> updateDisplayName(String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.updateDisplayName(displayName);
      ref.invalidate(authStateProvider);
    });
  }

  Future<void> updatePhotoUrl(String? photoUrl) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.updatePhotoUrl(photoUrl);
      ref.invalidate(authStateProvider);
    });
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.deleteAccount();
    });
  }
}
