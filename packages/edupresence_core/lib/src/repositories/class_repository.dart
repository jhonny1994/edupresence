import 'package:edupresence_core/src/models/class.dart';
import 'package:edupresence_core/src/repositories/base_repository.dart';
import 'package:edupresence_supabase/edupresence_supabase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'class_repository.g.dart';

/// Repository for managing classes in the database
class ClassRepository extends BaseRepository {
  /// Creates a new [ClassRepository] instance
  const ClassRepository(super.client);

  /// Get a class by its ID
  Future<Class?> getClass(String id) async {
    try {
      final response =
          await client.from('classes').select().eq('id', id).maybeSingle();

      if (response == null) return null;
      return Class.fromJson(response);
    } on PostgrestException {
      return null;
    }
  }

  /// Get all classes
  Future<List<Class>> getClasses() async {
    final response = await client.from('classes').select();
    return response.cast<Map<String, dynamic>>().map(Class.fromJson).toList();
  }

  /// Get all classes for a specific professor
  Future<List<Class>> getClassesByProfessor(String professorId) async {
    final response =
        await client.from('classes').select().eq('professor_id', professorId);
    return response.cast<Map<String, dynamic>>().map(Class.fromJson).toList();
  }

  /// Create a new class
  Future<Class> createClass(Class classData) async {
    final response = await client
        .from('classes')
        .insert(classData.toJson())
        .select()
        .single();
    return Class.fromJson(response);
  }

  /// Update an existing class
  Future<Class> updateClass(Class classData) async {
    final response = await client
        .from('classes')
        .update(classData.toJson())
        .eq('id', classData.id)
        .select()
        .single();
    return Class.fromJson(response);
  }

  /// Delete a class
  Future<void> deleteClass(String id) async {
    await client.from('classes').delete().eq('id', id);
  }
}

/// Provider for the class repository
@Riverpod(keepAlive: true)
ClassRepository classRepository(Ref ref) {
  return ClassRepository(ref.watch(supabaseClientProvider));
}
