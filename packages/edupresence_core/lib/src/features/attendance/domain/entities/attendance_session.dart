import 'package:edupresence_core/src/shared/domain/enums/session_status.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/unique_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_session.freezed.dart';

@freezed
class AttendanceSession with _$AttendanceSession {
  const factory AttendanceSession({
    required UniqueId id,
    required UniqueId classId,
    required DateTime date,
    required DateTime startTime,
    required DateTime? endTime,
    required SessionStatus status,
    required UniqueId createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AttendanceSession;
}
