import 'package:dartz/dartz.dart';

import 'package:edupresence_core/src/features/attendance/domain/entities/attendance_record.dart';
import 'package:edupresence_core/src/features/attendance/domain/entities/attendance_session.dart';
import 'package:edupresence_core/src/features/attendance/domain/repositories/attendance_failure.dart';
import 'package:edupresence_core/src/shared/domain/enums/attendance_status.dart';
import 'package:edupresence_core/src/shared/domain/enums/session_status.dart';

/// Repository interface for managing attendance sessions and records
abstract class IAttendanceRepository {
  /// Watch stream of attendance sessions for a specific class
  Stream<Either<AttendanceFailure, List<AttendanceSession>>> watchClassSessions(
    String classId,
  );

  /// Watch stream of attendance records for a specific session
  Stream<Either<AttendanceFailure, List<AttendanceRecord>>> watchSessionRecords(
    String sessionId,
  );

  /// Watch stream of attendance records for a specific student in a class
  Stream<Either<AttendanceFailure, List<AttendanceRecord>>>
      watchStudentClassAttendance({
    required String classId,
    required String studentId,
  });

  /// Get a specific attendance session by ID
  Future<Either<AttendanceFailure, AttendanceSession>> getSession(
    String sessionId,
  );

  /// Create a new attendance session
  Future<Either<AttendanceFailure, AttendanceSession>> createSession({
    required String classId,
    required DateTime date,
    required DateTime startTime,
    required Duration duration,
    Map<String, dynamic>? locationRequirements,
  });

  /// Update an existing attendance session
  Future<Either<AttendanceFailure, Unit>> updateSession({
    required String sessionId,
    DateTime? endTime,
    SessionStatus? status,
    Map<String, dynamic>? locationRequirements,
  });

  /// End an attendance session
  Future<Either<AttendanceFailure, Unit>> endSession(String sessionId);

  /// Mark attendance for a single student
  Future<Either<AttendanceFailure, Unit>> markAttendance({
    required String sessionId,
    required String studentId,
    required AttendanceStatus status,
    required DateTime checkInTime,
    Map<String, dynamic>? locationData,
  });

  /// Mark attendance for multiple students at once
  Future<Either<AttendanceFailure, Unit>> markBulkAttendance({
    required String sessionId,
    required List<String> studentIds,
    required AttendanceStatus status,
    required DateTime checkInTime,
  });

  /// Get attendance record for a specific student in a session
  Future<Either<AttendanceFailure, AttendanceRecord>> getStudentAttendance({
    required String sessionId,
    required String studentId,
  });

  /// Get attendance statistics for a class
  Future<Either<AttendanceFailure, Map<String, dynamic>>> getClassStatistics(
    String classId,
  );

  /// Get attendance statistics for a student in a class
  Future<Either<AttendanceFailure, Map<String, dynamic>>>
      getStudentClassStatistics({
    required String classId,
    required String studentId,
  });
}
