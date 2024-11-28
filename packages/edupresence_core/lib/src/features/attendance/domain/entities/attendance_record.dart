import 'package:edupresence_core/src/shared/domain/enums/attendance_status.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/unique_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_record.freezed.dart';

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required UniqueId id,
    required UniqueId sessionId,
    required UniqueId studentId,
    required AttendanceStatus status,
    required DateTime? checkInTime,
    required Map<String, dynamic>? locationData,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AttendanceRecord;
}
