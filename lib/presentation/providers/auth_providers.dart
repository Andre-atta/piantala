import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piantala/data/repositories/auth_repository_impl.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/domain/repositories/i_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref) {
  // FIX A-03: inietta sempre FirebaseFirestore.instance in modo esplicito
  // per garantire testabilità e coerenza con il costruttore non-nullable.
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

@riverpod
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
      final repository = ref.read(authRepositoryProvider);
      await repository.signOut();
    });
  }
}
