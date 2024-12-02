import 'dart:async';

import 'package:edupresence_core/src/features/auth/application/auth_service.dart';
import 'package:edupresence_core/src/features/auth/application/auth_state.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/auth_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// Notifier that manages the authentication state
@riverpod
class AuthNotifier extends _$AuthNotifier {
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  AuthState build() {
    _startWatchingAuthState();
    return const AuthState.initial();
  }

  /// Start watching the authentication state
  void _startWatchingAuthState() {
    ref.onDispose(() {
      _authStateSubscription?.cancel();
    });

    _authStateSubscription = ref
        .read(authServiceProvider)
        .watchAuthState()
        .map(
          (userOption) => userOption.fold(
            () => const AuthState.unauthenticated(),
            AuthState.authenticated,
          ),
        )
        .handleError(
          (Object error) => state = AuthState.failure(
            error is AuthFailure ? error : const AuthFailure.serverError(),
          ),
        )
        .listen(
          (authState) => state = authState,
          onError: (Object error) => state = AuthState.failure(
            error is AuthFailure ? error : const AuthFailure.serverError(),
          ),
        );
  }

  /// Register a new user with email and password
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.authenticating();

    final failureOrSuccess = await ref
        .read(authServiceProvider)
        .registerWithEmailAndPassword(email: email, password: password);

    state = failureOrSuccess.fold(
      AuthState.failure,
      (_) => const AuthState.unauthenticated(),
    );
  }

  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthState.authenticating();

    final failureOrSuccess = await ref
        .read(authServiceProvider)
        .signInWithEmailAndPassword(email: email, password: password);

    state = failureOrSuccess.fold(
      AuthState.failure,
      (_) => state, // Keep current state as watchAuthState will update it
    );
  }

  /// Sign out the current user
  Future<void> signOut() async {
    state = const AuthState.authenticating();

    final failureOrSuccess = await ref.read(authServiceProvider).signOut();

    state = failureOrSuccess.fold(
      AuthState.failure,
      (_) => const AuthState.unauthenticated(),
    );
  }

  /// Check if the user is authenticated
  Future<void> checkAuthStatus() async {
    state = const AuthState.authenticating();

    final userOption = await ref.read(authServiceProvider).getSignedInUser();

    state = userOption.fold(
      () => const AuthState.unauthenticated(),
      AuthState.authenticated,
    );
  }
}
