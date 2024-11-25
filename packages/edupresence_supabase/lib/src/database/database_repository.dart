import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling database operations
class DatabaseRepository {
  final SupabaseClient _client;

  DatabaseRepository(this._client);

  /// Get user profile data
  Future<Map<String, dynamic>?> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  /// Update user profile data
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await _client
        .from('profiles')
        .update(data)
        .eq('id', userId);
  }

  /// Get classes for a professor
  Future<List<Map<String, dynamic>>> getProfessorClasses(String professorId) async {
    final response = await _client
        .from('classes')
        .select()
        .eq('professor_id', professorId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get enrolled classes for a student
  Future<List<Map<String, dynamic>>> getStudentClasses(String studentId) async {
    final response = await _client
        .from('class_enrollments')
        .select('*, classes(*)')
        .eq('student_id', studentId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Create a new class
  Future<void> createClass(Map<String, dynamic> classData) async {
    await _client
        .from('classes')
        .insert(classData);
  }

  /// Create a new attendance session
  Future<Map<String, dynamic>> createAttendanceSession(Map<String, dynamic> sessionData) async {
    final response = await _client
        .from('attendance_sessions')
        .insert(sessionData)
        .select()
        .single();
    return response;
  }

  /// Record student attendance
  Future<void> recordAttendance(Map<String, dynamic> attendanceData) async {
    await _client
        .from('attendance_records')
        .insert(attendanceData);
  }

  /// Get attendance records for a session
  Future<List<Map<String, dynamic>>> getSessionAttendance(String sessionId) async {
    final response = await _client
        .from('attendance_records')
        .select('*, profiles(*)')
        .eq('session_id', sessionId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get student attendance history
  Future<List<Map<String, dynamic>>> getStudentAttendanceHistory(String studentId) async {
    final response = await _client
        .from('attendance_records')
        .select('*, attendance_sessions(*), classes(*)')
        .eq('student_id', studentId);
    return List<Map<String, dynamic>>.from(response);
  }
}
