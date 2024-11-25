import 'package:edupresence_core/src/models/attendance_record.dart';
import 'package:edupresence_core/src/repositories/base_repository.dart';
import 'package:edupresence_supabase/edupresence_supabase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'attendance_record_repository.g.dart';

/// Repository for managing attendance records in the database
class AttendanceRecordRepository extends BaseRepository {
  /// Creates a new [AttendanceRecordRepository] instance
  const AttendanceRecordRepository(super.client);

  /// Get a record by its ID
  Future<AttendanceRecord?> getRecord(String id) async {
    try {
      final response = await client
          .from('attendance_records')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;
      return AttendanceRecord.fromJson(response);
    } on PostgrestException {
      return null;
    }
  }

  /// Get all records
  Future<List<AttendanceRecord>> getRecords() async {
    final response = await client.from('attendance_records').select();
    return response
        .cast<Map<String, dynamic>>()
        .map(AttendanceRecord.fromJson)
        .toList();
  }

  /// Get all records for a specific session
  Future<List<AttendanceRecord>> getRecordsBySession(String sessionId) async {
    final response = await client
        .from('attendance_records')
        .select()
        .eq('session_id', sessionId);
    return response
        .cast<Map<String, dynamic>>()
        .map(AttendanceRecord.fromJson)
        .toList();
  }

  /// Get all records for a specific student
  Future<List<AttendanceRecord>> getRecordsByStudent(String studentId) async {
    final response = await client
        .from('attendance_records')
        .select()
        .eq('student_id', studentId);
    return response
        .cast<Map<String, dynamic>>()
        .map(AttendanceRecord.fromJson)
        .toList();
  }

  /// Create a new record
  Future<AttendanceRecord> createRecord(AttendanceRecord record) async {
    final response = await client
        .from('attendance_records')
        .insert(record.toJson())
        .select()
        .single();
    return AttendanceRecord.fromJson(response);
  }

  /// Update an existing record
  Future<AttendanceRecord> updateRecord(AttendanceRecord record) async {
    final response = await client
        .from('attendance_records')
        .update(record.toJson())
        .eq('id', record.id)
        .select()
        .single();
    return AttendanceRecord.fromJson(response);
  }

  /// Delete a record
  Future<void> deleteRecord(String id) async {
    await client.from('attendance_records').delete().eq('id', id);
  }
}

/// Provider for the attendance record repository
@Riverpod(keepAlive: true)
AttendanceRecordRepository attendanceRecordRepository(
  Ref ref,
) {
  return AttendanceRecordRepository(ref.watch(supabaseClientProvider));
}
