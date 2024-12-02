import 'dart:developer' as developer;

import 'package:edupresence_core/src/shared/infrastructure/logging/i_logger.dart';

/// A simple logger implementation for development
class DevLogger implements ILogger {
  const DevLogger();

  @override
  void debug(String message, [Map<String, dynamic>? data]) {
    _log('DEBUG', message, data);
  }

  @override
  void info(String message, [Map<String, dynamic>? data]) {
    _log('INFO', message, data);
  }

  @override
  void warning(String message, [Map<String, dynamic>? data]) {
    _log('WARNING', message, data);
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _log(String level, String message, [Map<String, dynamic>? data]) {
    developer.log(
      message,
      name: level,
      error: data != null ? 'Data: $data' : null,
    );
  }
}
