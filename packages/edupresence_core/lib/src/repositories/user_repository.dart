import 'package:edupresence_core/src/models/user.dart' as models;
import 'package:edupresence_core/src/repositories/base_repository.dart';
import 'package:edupresence_supabase/edupresence_supabase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_repository.g.dart';

/// Repository for managing users in the database
class UserRepository extends BaseRepository {
  /// Creates a new [UserRepository] instance
  const UserRepository(super.client);

  /// Get a user by their ID
  Future<models.User?> getUser(String id) async {
    try {
      final response =
          await client.from('users').select().eq('id', id).maybeSingle();

      if (response == null) return null;
      return models.User.fromJson(response);
    } on PostgrestException {
      return null;
    }
  }

  /// Get all users
  Future<List<models.User>> getUsers() async {
    final response = await client.from('users').select();
    return response
        .cast<Map<String, dynamic>>()
        .map(models.User.fromJson)
        .toList();
  }

  /// Get all professors
  Future<List<models.User>> getProfessors() async {
    final response =
        await client.from('users').select().eq('is_professor', true);
    return response
        .cast<Map<String, dynamic>>()
        .map(models.User.fromJson)
        .toList();
  }

  /// Get all students
  Future<List<models.User>> getStudents() async {
    final response =
        await client.from('users').select().eq('is_professor', false);
    return response
        .cast<Map<String, dynamic>>()
        .map(models.User.fromJson)
        .toList();
  }

  /// Create a new user
  Future<models.User> createUser(models.User user) async {
    final response =
        await client.from('users').insert(user.toJson()).select().single();
    return models.User.fromJson(response);
  }

  /// Update an existing user
  Future<models.User> updateUser(models.User user) async {
    final response = await client
        .from('users')
        .update(user.toJson())
        .eq('id', user.id)
        .select()
        .single();
    return models.User.fromJson(response);
  }

  /// Delete a user
  Future<void> deleteUser(String id) async {
    await client.from('users').delete().eq('id', id);
  }
}

/// Provider for the user repository
@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepository(ref.watch(supabaseClientProvider));
}
