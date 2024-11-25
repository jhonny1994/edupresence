import 'package:supabase_flutter/supabase_flutter.dart';

/// Custom exception for database operations
class DatabaseException implements Exception {
  /// Create a new [DatabaseException]
  DatabaseException(this.message, this.error);

  /// Error message
  final String message;

  /// Original error
  final dynamic error;

  @override
  String toString() => 'DatabaseException: $message';
}

/// Repository for handling database operations
class DatabaseRepository {
  /// Create a new [DatabaseRepository] instance
  DatabaseRepository(this._client);

  final SupabaseClient _client;

  /// Get user profile data
  Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      throw DatabaseException('Failed to get profile', e);
    }
  }

  /// Update user profile data
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    try {
      await _client
          .from('profiles')
          .update(data)
          .eq('id', userId);
    } catch (e) {
      throw DatabaseException('Failed to update profile', e);
    }
  }

  /// Get classes for a professor
  Future<List<Map<String, dynamic>>> getProfessorClasses(String professorId) async {
    try {
      final response = await _client
          .from('classes')
          .select()
          .eq('professor_id', professorId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException('Failed to get professor classes', e);
    }
  }

  /// Get enrolled classes for a student
  Future<List<Map<String, dynamic>>> getStudentClasses(String studentId) async {
    try {
      final response = await _client
          .from('class_enrollments')
          .select('*, classes(*)')
          .eq('student_id', studentId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException('Failed to get student classes', e);
    }
  }

  /// Create a new class
  Future<void> createClass(Map<String, dynamic> classData) async {
    try {
      await _client
          .from('classes')
          .insert(classData);
    } catch (e) {
      throw DatabaseException('Failed to create class', e);
    }
  }

  /// Create a new attendance session
  Future<Map<String, dynamic>> createAttendanceSession(Map<String, dynamic> sessionData) async {
    try {
      final response = await _client
          .from('attendance_sessions')
          .insert(sessionData)
          .select()
          .single();
      return response;
    } catch (e) {
      throw DatabaseException('Failed to create attendance session', e);
    }
  }

  /// Record student attendance
  Future<void> recordAttendance(Map<String, dynamic> attendanceData) async {
    try {
      await _client
          .from('attendance_records')
          .insert(attendanceData);
    } catch (e) {
      throw DatabaseException('Failed to record attendance', e);
    }
  }

  /// Get attendance records for a session
  Future<List<Map<String, dynamic>>> getSessionAttendance(String sessionId) async {
    try {
      final response = await _client
          .from('attendance_records')
          .select('*, profiles(*)')
          .eq('session_id', sessionId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException('Failed to get session attendance', e);
    }
  }

  /// Get student attendance history
  Future<List<Map<String, dynamic>>> getStudentAttendanceHistory(String studentId) async {
    try {
      final response = await _client
          .from('attendance_records')
          .select('*, attendance_sessions(*), classes(*)')
          .eq('student_id', studentId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException('Failed to get student attendance history', e);
    }
  }

  /// Subscribe to real-time attendance updates for a session
  Stream<List<Map<String, dynamic>>> subscribeToSessionAttendance(String sessionId) {
    return _client
        .from('attendance_records')
        .stream(primaryKey: ['id'])
        .eq('session_id', sessionId)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  /// Subscribe to real-time class updates for a professor
  Stream<List<Map<String, dynamic>>> subscribeToProfessorClasses(String professorId) {
    return _client
        .from('classes')
        .stream(primaryKey: ['id'])
        .eq('professor_id', professorId)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  /// Subscribe to real-time attendance session updates for a class
  Stream<List<Map<String, dynamic>>> subscribeToClassSessions(String classId) {
    return _client
        .from('attendance_sessions')
        .stream(primaryKey: ['id'])
        .eq('class_id', classId)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  /// Subscribe to real-time profile updates
  Stream<Map<String, dynamic>> subscribeToProfile(String userId) {
    return _client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((data) => data.first);
  }

  /// Get active attendance sessions for a class
  Future<List<Map<String, dynamic>>> getActiveClassSessions(String classId) async {
    try {
      final response = await _client
          .from('attendance_sessions')
          .select()
          .eq('class_id', classId)
          .eq('is_active', true);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException('Failed to get active class sessions', e);
    }
  }

  /// Close an attendance session
  Future<void> closeAttendanceSession(String sessionId) async {
    try {
      await _client
          .from('attendance_sessions')
          .update({'is_active': false})
          .eq('id', sessionId);
    } catch (e) {
      throw DatabaseException('Failed to close attendance session', e);
    }
  }
}
