/// The status of an attendance session
enum SessionStatus {
  /// Session is scheduled but hasn't started yet
  scheduled('Scheduled'),

  /// Session is currently active and accepting attendance
  active('Active'),

  /// Session has been completed normally
  completed('Completed'),

  /// Session was cancelled before completion
  cancelled('Cancelled'),

  /// Session was marked as invalid due to technical issues
  invalid('Invalid');

  const SessionStatus(this.label);

  /// Display label for the status
  final String label;

  /// Check if the session is scheduled but not started
  bool get isScheduled => this == SessionStatus.scheduled;

  /// Check if the session is currently active
  bool get isActive => this == SessionStatus.active;

  /// Check if the session has been completed
  bool get isCompleted => this == SessionStatus.completed;

  /// Check if the session was cancelled
  bool get isCancelled => this == SessionStatus.cancelled;

  /// Check if the session was marked as invalid
  bool get isInvalid => this == SessionStatus.invalid;

  /// Check if attendance can be marked in this session
  bool get canMarkAttendance => this == SessionStatus.active;

  /// Check if the session ended normally (completed, not cancelled or invalid)
  bool get endedNormally => this == SessionStatus.completed;

  /// Check if the session data should be included in statistics
  bool get includeInStatistics =>
      this == SessionStatus.completed && !isInvalid && !isCancelled;
}
