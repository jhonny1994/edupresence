import 'dart:developer' as developer;

import 'package:edupresence_core/src/shared/infrastructure/error/i_error_reporter.dart';

/// A simple error reporter implementation for development
class DevErrorReporter implements IErrorReporter {
  const DevErrorReporter();

  @override
  Future<void> reportError(dynamic error, StackTrace stackTrace) async {
    developer.log(
      'Non-fatal error reported',
      error: error,
      stackTrace: stackTrace,
      name: 'DevErrorReporter',
    );
  }

  @override
  Future<void> reportFatalError(dynamic error, StackTrace stackTrace) async {
    developer.log(
      'Fatal error reported',
      error: error,
      stackTrace: stackTrace,
      name: 'DevErrorReporter',
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    developer.log(
      'User ID set: $userId',
      name: 'DevErrorReporter',
    );
  }

  @override
  Future<void> setCustomKey(String key, dynamic value) async {
    developer.log(
      'Custom key set: $key = $value',
      name: 'DevErrorReporter',
    );
  }
}
