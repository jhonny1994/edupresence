import 'package:edupresence_core/src/shared/infrastructure/error/i_error_reporter.dart';
import 'package:edupresence_core/src/shared/infrastructure/logging/i_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_handler.g.dart';

/// A service that handles errors by logging them and reporting them to an error tracking service
class ErrorHandler {
  const ErrorHandler({
    required ILogger logger,
    required IErrorReporter errorReporter,
  })  : _logger = logger,
        _errorReporter = errorReporter;

  final ILogger _logger;
  final IErrorReporter _errorReporter;

  /// Handle a non-fatal error
  Future<void> handleError(
    dynamic error,
    StackTrace stackTrace, {
    String? context,
  }) async {
    final message = context != null ? '$context: $error' : error.toString();
    _logger.error(message, error, stackTrace);
    await _errorReporter.reportError(error, stackTrace);
  }

  /// Handle a fatal error that crashes the app
  Future<void> handleFatalError(
    dynamic error,
    StackTrace stackTrace, {
    String? context,
  }) async {
    final message = context != null ? '$context: $error' : error.toString();
    _logger.error(message, error, stackTrace);
    await _errorReporter.reportFatalError(error, stackTrace);
  }

  /// Set the user ID for error tracking
  Future<void> setUserId(String userId) async {
    await _errorReporter.setUserId(userId);
  }

  /// Add custom data to error reports
  Future<void> setCustomData(String key, dynamic value) async {
    await _errorReporter.setCustomKey(key, value);
  }
}

/// Provider for the error handler
@riverpod
ErrorHandler errorHandler(Ref ref) {
  throw UnimplementedError('Provide logger and error reporter implementations');
}
