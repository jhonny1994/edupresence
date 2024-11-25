import 'package:edupresence_core/src/models/attendance_session.dart';
import 'package:edupresence_core/src/repositories/base_repository.dart';
import 'package:edupresence_supabase/edupresence_supabase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'attendance_session_repository.g.dart';

/// Repository for managing attendance sessions in the database
class AttendanceSessionRepository extends BaseRepository {
  /// Creates a new [AttendanceSessionRepository] instance
  const AttendanceSessionRepository(super.client);

  /// Get a session by its ID
  Future<AttendanceSession?> getSession(String id) async {
    try {
      final response = await client
          .from('attendance_sessions')
          .select()
          .eq('id', id)
          .single();
      return AttendanceSession.fromJson(response);
    } on PostgrestException catch (_) {
      return null;
    }
  }

  /// Get all sessions
  Future<List<AttendanceSession>> getSessions() async {
    final response = await client.from('attendance_sessions').select();
    return response.map(AttendanceSession.fromJson).toList();
  }

  /// Get all sessions for a specific class
  Future<List<AttendanceSession>> getSessionsByClass(String classId) async {
    final response = await client
        .from('attendance_sessions')
        .select()
        .eq('class_id', classId);
    return response.map(AttendanceSession.fromJson).toList();
  }

  /// Get active sessions for a specific class
  Future<List<AttendanceSession>> getActiveSessionsByClass(
    String classId,
  ) async {
    final response = await client
        .from('attendance_sessions')
        .select()
        .eq('class_id', classId)
        .eq('is_active', true);
    return response.map(AttendanceSession.fromJson).toList();
  }

  /// Create a new session
  Future<AttendanceSession> createSession(AttendanceSession session) async {
    final response = await client
        .from('attendance_sessions')
        .insert(session.toJson())
        .select()
        .single();
    return AttendanceSession.fromJson(response);
  }

  /// Update an existing session
  Future<AttendanceSession> updateSession(AttendanceSession session) async {
    final response = await client
        .from('attendance_sessions')
        .update(session.toJson())
        .eq('id', session.id)
        .select()
        .single();
    return AttendanceSession.fromJson(response);
  }

  /// Delete a session
  Future<void> deleteSession(String id) async {
    await client.from('attendance_sessions').delete().eq('id', id);
  }
}

/// Provider for the attendance session repository
@Riverpod(keepAlive: true)
AttendanceSessionRepository attendanceSessionRepository(
  Ref ref,
) {
  return AttendanceSessionRepository(ref.watch(supabaseClientProvider));
}
