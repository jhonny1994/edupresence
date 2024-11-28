/// The status of a student's attendance in a session
enum AttendanceStatus {
  /// Student is present and on time
  present('Present'),

  /// Student is present but arrived late
  late('Late'),

  /// Student is absent without excuse
  absent('Absent'),

  /// Student is absent with a valid excuse
  excused('Excused');

  const AttendanceStatus(this.label);

  /// Display label for the status
  final String label;

  /// Check if the status is considered present (either on time or late)
  bool get isPresent => this == AttendanceStatus.present;

  /// Check if the status is marked as late
  bool get isLate => this == AttendanceStatus.late;

  /// Check if the status is marked as absent (either excused or unexcused)
  bool get isAbsent =>
      this == AttendanceStatus.absent || this == AttendanceStatus.excused;

  /// Check if the status is marked as excused absence
  bool get isExcused => this == AttendanceStatus.excused;

  /// Check if the attendance is valid for participation
  bool get isValidForParticipation =>
      this == AttendanceStatus.present || this == AttendanceStatus.late;
}
