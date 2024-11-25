import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling authentication-related operations
class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

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
}
