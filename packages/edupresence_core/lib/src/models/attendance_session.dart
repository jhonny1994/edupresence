import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_session.freezed.dart';
part 'attendance_session.g.dart';

@freezed
class AttendanceSession with _$AttendanceSession {
  const factory AttendanceSession({
    required String id,
    required String classId,
    required DateTime startTime,
    required DateTime endTime,
    required String qrCode,
    @Default(false) bool isActive,
  }) = _AttendanceSession;

  factory AttendanceSession.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSessionFromJson(json);
}
