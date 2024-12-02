/// Interface for logging functionality
abstract class ILogger {
  /// Log a debug message
  void debug(String message, [Map<String, dynamic>? data]);

  /// Log an info message
  void info(String message, [Map<String, dynamic>? data]);

  /// Log a warning message
  void warning(String message, [Map<String, dynamic>? data]);

  /// Log an error message
  void error(String message, [dynamic error, StackTrace? stackTrace]);
}
