import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:edupresence_core/edupresence_core.dart' as core;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements core.IAuthRepository {
  SupabaseAuthRepository(this._supabase);
  final SupabaseClient _supabase;
  @override
  Future<Option<core.User>> getSignedInUser() async {
    final session = _supabase.auth.currentSession;
    if (session == null) return none();

    final metadata = session.user.userMetadata;
    return some(
      core.User(
        id: core.UniqueId.fromUniqueString(session.user.id),
        email: core.EmailAddress(session.user.email ?? ''),
        name: metadata?['full_name'] as String? ?? '',
        role: metadata?['role'] as String? ?? 'student',
      ),
    );
  }

  @override
  Future<Either<core.AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('already registered')) {
        return left(const core.AuthFailure.emailAlreadyInUse());
      }
      if (e.message.contains('weak password')) {
        return left(const core.AuthFailure.weakPassword());
      }
      if (e.message.contains('invalid email')) {
        return left(const core.AuthFailure.authInvalidEmail());
      }
      return left(const core.AuthFailure.serverError());
    } on TimeoutException {
      return left(const core.AuthFailure.networkError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
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
      if (e.message.contains('Too many requests')) {
        return left(const core.AuthFailure.tooManyRequests());
      }
      return left(const core.AuthFailure.serverError());
    } on TimeoutException {
      return left(const core.AuthFailure.networkError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return right(unit);
    } on AuthException {
      return left(const core.AuthFailure.serverError());
    } on TimeoutException {
      return left(const core.AuthFailure.networkError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.edupresence://reset-callback/',
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('Email not found')) {
        return left(const core.AuthFailure.authInvalidEmail());
      }
      return left(const core.AuthFailure.serverError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('weak')) {
        return left(const core.AuthFailure.weakPassword());
      }
      return left(const core.AuthFailure.serverError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> sendEmailVerification() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return left(const core.AuthFailure.serverError());
      }

      // Supabase automatically sends verification email during registration
      // This method can be used to resend the verification email
      await _supabase.auth.resend(
        type: OtpType.email,
        email: user.email,
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('rate limit')) {
        return left(const core.AuthFailure.tooManyRequests());
      }
      return left(const core.AuthFailure.serverError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
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
    } on AuthException {
      return left(const core.AuthFailure.serverError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Future<Either<core.AuthFailure, Unit>> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.edupresence://callback',
      );
      return right(unit);
    } on AuthException catch (e) {
      if (e.message.contains('cancelled')) {
        return left(const core.AuthFailure.cancelledByUser());
      }
      return left(const core.AuthFailure.serverError());
    } catch (_) {
      return left(const core.AuthFailure.serverError());
    }
  }

  @override
  Stream<Option<core.User>> watchAuthState() {
    return _supabase.auth.onAuthStateChange
        .handleError((error) => null)
        .map<Option<core.User>>((event) {
      final user = event.session?.user;
      if (user == null) return none<core.User>();

      return some(
        core.User(
          id: core.UniqueId.fromUniqueString(user.id),
          email: core.EmailAddress(user.email ?? ''),
          name: user.userMetadata?['full_name'] as String? ?? '',
          role: user.userMetadata?['role'] as String? ?? 'student',
        ),
      );
    }).handleError((_) => none<core.User>());
  }
}
