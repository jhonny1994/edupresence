import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/auth_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';

/// Maps value failures to auth failures
class FailureMapper {
  const FailureMapper._();

  /// Maps a value failure to an auth failure
  static Either<AuthFailure, Unit> mapToAuthFailure<T>(ValueFailure<T> failure) {
    return left(
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
    );
  }
}
