import 'package:edupresence_core/src/features/auth/domain/entities/user.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/auth_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Represents the state of authentication
@freezed
class AuthState with _$AuthState {
  /// Initial state when the app starts
  const factory AuthState.initial() = _Initial;

  /// State when authentication status is being determined
  const factory AuthState.authenticating() = _Authenticating;

  /// State when user is authenticated
  const factory AuthState.authenticated(User user) = _Authenticated;

  /// State when user is not authenticated
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// State when authentication fails
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}
