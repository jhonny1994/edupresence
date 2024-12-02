import 'package:dartz/dartz.dart';

import 'package:edupresence_core/src/features/auth/domain/entities/user.dart';
import 'package:edupresence_core/src/features/auth/domain/repositories/auth_failure.dart';

abstract class IAuthRepository {
  Stream<Option<User>> watchAuthState();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Option<User>> getSignedInUser();

  /// Sends a password reset email to the provided email address
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email);

  /// Updates the user's password using a password reset token
  Future<Either<AuthFailure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Sends an email verification link to the current user's email
  Future<Either<AuthFailure, Unit>> sendEmailVerification();

  /// Checks if the current user's email is verified
  Future<Either<AuthFailure, bool>> isEmailVerified();

  /// Sign in with Google
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
