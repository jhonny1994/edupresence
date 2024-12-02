import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/features/auth/domain/entities/user.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/auth_failure.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:edupresence_core/src/features/auth/infrastructure/providers.dart';
import 'package:edupresence_core/src/shared/domain/validation/form_validation.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/email_address.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

/// Service class that handles authentication business logic
class AuthService {
  const AuthService(this._authRepository);

  final IAuthRepository _authRepository;

  /// Stream of the current authenticated user
  Stream<Option<User>> watchAuthState() => _authRepository.watchAuthState();

  /// Get the current signed-in user
  Future<Option<User>> getSignedInUser() => _authRepository.getSignedInUser();

  /// Register a new user with email and password
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final emailAddress = EmailAddress(email);
    final passwordObj = Password(password);

    final validationResult =
        FormValidation.combine([emailAddress, passwordObj]);

    if (validationResult.isLeft()) {
      // Map value failures to auth failures
      return validationResult.fold<Either<AuthFailure, Unit>>(
        (failure) => left(
          failure.map(
            invalidEmail: (_) => const AuthFailure.authInvalidEmail(),
            shortPassword: (_) => const AuthFailure.weakPassword(),
            invalidPhoneNumber: (_) => const AuthFailure.serverError(),
            empty: (_) => const AuthFailure.serverError(),
            exceedingLength: (_) => const AuthFailure.serverError(),
            shortInput: (_) => const AuthFailure.serverError(),
            invalidCharacters: (_) => const AuthFailure.serverError(),
            missingUppercase: (_) => const AuthFailure.weakPassword(),
            missingLowercase: (_) => const AuthFailure.weakPassword(),
            missingNumber: (_) => const AuthFailure.weakPassword(),
            missingSpecialCharacter: (_) => const AuthFailure.weakPassword(),
            invalidPattern: (_) => const AuthFailure.serverError(),
            numberTooLow: (_) => const AuthFailure.serverError(),
            numberTooHigh: (_) => const AuthFailure.serverError(),
          ),
        ),
        (_) => throw Error(), // This should never happen
      );
    }

    return _authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in with email and password
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final emailAddress = EmailAddress(email);
    final passwordObj = Password(password);

    final validationResult =
        FormValidation.combine([emailAddress, passwordObj]);

    if (validationResult.isLeft()) {
      return validationResult.fold<Either<AuthFailure, Unit>>(
        (failure) => left(
          failure.map(
            invalidEmail: (_) => const AuthFailure.authInvalidEmail(),
            shortPassword: (_) => const AuthFailure.weakPassword(),
            invalidPhoneNumber: (_) => const AuthFailure.serverError(),
            empty: (_) => const AuthFailure.serverError(),
            exceedingLength: (_) => const AuthFailure.serverError(),
            shortInput: (_) => const AuthFailure.serverError(),
            invalidCharacters: (_) => const AuthFailure.serverError(),
            missingUppercase: (_) => const AuthFailure.weakPassword(),
            missingLowercase: (_) => const AuthFailure.weakPassword(),
            missingNumber: (_) => const AuthFailure.weakPassword(),
            missingSpecialCharacter: (_) => const AuthFailure.weakPassword(),
            invalidPattern: (_) => const AuthFailure.serverError(),
            numberTooLow: (_) => const AuthFailure.serverError(),
            numberTooHigh: (_) => const AuthFailure.serverError(),
          ),
        ),
        (_) => throw Error(), // This should never happen
      );
    }

    return _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign out the current user
  Future<Either<AuthFailure, Unit>> signOut() => _authRepository.signOut();

  /// Send a password reset email to the provided email address
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) async {
    final emailAddress = EmailAddress(email);

    final validationResult = FormValidation.combine([emailAddress]);

    if (validationResult.isLeft()) {
      return validationResult.fold<Either<AuthFailure, Unit>>(
        (failure) => left(
          failure.map(
            invalidEmail: (_) => const AuthFailure.authInvalidEmail(),
            shortPassword: (_) => const AuthFailure.serverError(),
            invalidPhoneNumber: (_) => const AuthFailure.serverError(),
            empty: (_) => const AuthFailure.serverError(),
            exceedingLength: (_) => const AuthFailure.serverError(),
            shortInput: (_) => const AuthFailure.serverError(),
            invalidCharacters: (_) => const AuthFailure.serverError(),
            missingUppercase: (_) => const AuthFailure.serverError(),
            missingLowercase: (_) => const AuthFailure.serverError(),
            missingNumber: (_) => const AuthFailure.serverError(),
            missingSpecialCharacter: (_) => const AuthFailure.serverError(),
            invalidPattern: (_) => const AuthFailure.serverError(),
            numberTooLow: (_) => const AuthFailure.serverError(),
            numberTooHigh: (_) => const AuthFailure.serverError(),
          ),
        ),
        (_) => throw Error(), // This should never happen
      );
    }

    return _authRepository.sendPasswordResetEmail(email);
  }

  /// Reset password using token and new password
  Future<Either<AuthFailure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final password = Password(newPassword);

    final validationResult = FormValidation.combine([password]);

    if (validationResult.isLeft()) {
      return validationResult.fold<Either<AuthFailure, Unit>>(
        (failure) => left(
          failure.map(
            invalidEmail: (_) => const AuthFailure.serverError(),
            shortPassword: (_) => const AuthFailure.weakPassword(),
            invalidPhoneNumber: (_) => const AuthFailure.serverError(),
            empty: (_) => const AuthFailure.serverError(),
            exceedingLength: (_) => const AuthFailure.serverError(),
            shortInput: (_) => const AuthFailure.serverError(),
            invalidCharacters: (_) => const AuthFailure.serverError(),
            missingUppercase: (_) => const AuthFailure.weakPassword(),
            missingLowercase: (_) => const AuthFailure.weakPassword(),
            missingNumber: (_) => const AuthFailure.weakPassword(),
            missingSpecialCharacter: (_) => const AuthFailure.weakPassword(),
            invalidPattern: (_) => const AuthFailure.serverError(),
            numberTooLow: (_) => const AuthFailure.serverError(),
            numberTooHigh: (_) => const AuthFailure.serverError(),
          ),
        ),
        (_) => throw Error(), // This should never happen
      );
    }

    return _authRepository.resetPassword(
      token: token,
      newPassword: newPassword,
    );
  }

  /// Send email verification to the current user
  Future<Either<AuthFailure, Unit>> sendEmailVerification() {
    return _authRepository.sendEmailVerification();
  }

  /// Check if the current user's email is verified
  Future<Either<AuthFailure, bool>> isEmailVerified() {
    return _authRepository.isEmailVerified();
  }

  /// Sign in with Google
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    return _authRepository.signInWithGoogle();
  }
}

/// Provider for the auth service
@riverpod
AuthService authService(Ref ref) {
  final repository = ref.watch<IAuthRepository>(authRepositoryProvider);
  return AuthService(repository);
}
