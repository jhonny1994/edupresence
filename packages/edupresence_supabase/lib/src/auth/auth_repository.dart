import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling authentication-related operations
class AuthRepository {
  /// Create a new [AuthRepository] instance
  AuthRepository(this._client);

  final SupabaseClient _client;

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required bool isProfessor,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'is_professor': isProfessor,
      },
    );
    return response;
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Get the current user
  User? get currentUser => _client.auth.currentUser;

  /// Stream of auth state changes
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  /// Send a password reset email
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.edupresence.app://reset-callback/',
    );
  }

  /// Update password for the current user
  Future<UserResponse> updatePassword(String newPassword) async {
    return await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  /// Send email verification to the current user
  Future<void> sendEmailVerification() async {
    if (currentUser == null) {
      throw Exception('No user is currently signed in');
    }
    await _client.auth.resend(
      type: OtpType.signup,
      email: currentUser!.email,
    );
  }

  /// Verify email with the received token
  Future<void> verifyEmail(String token) async {
    await _client.auth.verifyOTP(
      token: token,
      type: OtpType.signup,
      email: currentUser?.email,
    );
  }

  /// Refresh the current session
  Future<AuthResponse> refreshSession() async {
    final response = await _client.auth.refreshSession();
    return response;
  }

  /// Check if the current session is valid and refresh if needed
  Future<bool> validateSession() async {
    final session = _client.auth.currentSession;
    if (session == null) return false;

    try {
      if (session.isExpired) {
        await refreshSession();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get the current session
  Session? get currentSession => _client.auth.currentSession;

  /// Stream of session state changes
  Stream<AuthResponse> get onSessionRefresh => _client.auth.onAuthStateChange
      .where((state) => state.event == AuthChangeEvent.tokenRefreshed)
      .map((state) => AuthResponse(session: state.session));
}
