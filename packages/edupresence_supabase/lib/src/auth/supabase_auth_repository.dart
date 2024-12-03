import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:edupresence_core/edupresence_core.dart' as core;
import 'package:edupresence_supabase/src/auth/error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementation of [core.IAuthRepository] using Supabase
class SupabaseAuthRepository implements core.IAuthRepository {
  SupabaseAuthRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Stream<Option<core.User>> watchAuthState() {
    return _supabase.auth.onAuthStateChange.map((state) {
      final user = state.session?.user;
      if (user == null) return none();
      return some(
        core.User(
          id: core.UniqueId.fromUniqueString(user.id),
          email: core.EmailAddress(user.email ?? ''),
          name: user.userMetadata?['name'] as String? ?? '',
          role: user.userMetadata?['role'] as String? ?? 'student',
        ),
      );
    });
  }

  @override
  Future<Option<core.User>> getSignedInUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return none();
    return some(
      core.User(
        id: core.UniqueId.fromUniqueString(user.id),
        email: core.EmailAddress(user.email ?? ''),
        name: user.userMetadata?['name'] as String? ?? '',
        role: user.userMetadata?['role'] as String? ?? 'student',
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.signUp(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signOut() {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.signOut(),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> sendPasswordResetEmail(String email) {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.edupresence://reset-callback/',
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  }) {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> sendEmailVerification() {
    return SupabaseAuthErrorHandler.handle(() async {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw const AuthException('User not found');
      }
      return _supabase.auth.resend(
        type: OtpType.email,
        email: user.email,
      );
    });
  }

  @override
  Future<Either<core.AuthFailure, bool>> isEmailVerified() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return left(const core.AuthFailure.serverError());
      }

      // Refresh the session to get the latest email verification status
      await _supabase.auth.refreshSession();

      return right(user.emailConfirmedAt != null);
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signInWithGoogle() {
    return SupabaseAuthErrorHandler.handle(
      () => _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.edupresence://callback',
      ),
    );
  }
}
