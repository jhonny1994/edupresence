import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_failure.freezed.dart';

@freezed
class AttendanceFailure with _$AttendanceFailure {
  const factory AttendanceFailure.sessionNotFound() = SessionNotFound;
  const factory AttendanceFailure.attendanceInsufficientPermission() = AttendanceInsufficientPermission;
  const factory AttendanceFailure.attendanceServerError() = AttendanceServerError;
  const factory AttendanceFailure.sessionAlreadyEnded() = SessionAlreadyEnded;
  const factory AttendanceFailure.studentNotEnrolledInSession() = StudentNotEnrolledInSession;
  const factory AttendanceFailure.invalidAttendanceStatus() = InvalidAttendanceStatus;
}
