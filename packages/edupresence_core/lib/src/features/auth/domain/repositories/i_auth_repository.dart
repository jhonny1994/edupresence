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

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Either<AuthFailure, Unit>> signOut();

  Future<Option<User>> getSignedInUser();
}
