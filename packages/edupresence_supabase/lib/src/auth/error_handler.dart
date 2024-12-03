import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:edupresence_core/edupresence_core.dart' as core;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Extension method for handling Supabase auth errors
extension SupabaseAuthErrorHandler on Future<Either<core.AuthFailure, Unit>> {
  /// Handles common Supabase auth errors
  static Future<Either<core.AuthFailure, Unit>> handle<T>(
    Future<T> Function() call,
  ) async {
    try {
      await call();
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('Invalid login credentials')) {
        return left(
          const core.AuthFailure.invalidEmailAndPasswordCombination(),
        );
      }
      if (e.message.contains('Email not confirmed')) {
        return left(const core.AuthFailure.emailNotVerified());
      }
      if (e.message.contains('Too many requests') ||
          e.message.contains('rate limit')) {
        return left(const core.AuthFailure.tooManyRequests());
      }
      if (e.message.contains('already registered')) {
        return left(const core.AuthFailure.emailAlreadyInUse());
      }
      if (e.message.contains('weak password')) {
        return left(const core.AuthFailure.weakPassword());
      }
      if (e.message.contains('invalid email')) {
        return left(const core.AuthFailure.authInvalidEmail());
      }
      if (e.message.contains('cancelled')) {
        return left(const core.AuthFailure.cancelledByUser());
      }
      return left(const core.AuthFailure.serverError());
    } on TimeoutException {
      return left(const core.AuthFailure.networkError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }
}
