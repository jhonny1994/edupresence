import 'package:edupresence_core/src/config/env.dart';
import 'package:edupresence_core/src/shared/infrastructure/error/dev_error_reporter.dart';
import 'package:edupresence_core/src/shared/infrastructure/error/error_handler.dart';
import 'package:edupresence_core/src/shared/infrastructure/error/i_error_reporter.dart';
import 'package:edupresence_core/src/shared/infrastructure/logging/dev_logger.dart';
import 'package:edupresence_core/src/shared/infrastructure/logging/i_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/// Provider for the logger
@riverpod
ILogger logger(Ref ref) {
  if (Env.isDebug) {
    return const DevLogger();
  }
  // TODO: Add production logger implementation
  return const DevLogger();
}

/// Provider for the error reporter
@riverpod
IErrorReporter errorReporter(Ref ref) {
  if (Env.isDebug) {
    return const DevErrorReporter();
  }
  // TODO: Add production error reporter implementation
  return const DevErrorReporter();
}

/// Override the error handler provider to use our logger and error reporter
@riverpod
ErrorHandler errorHandler(Ref ref) {
  return ErrorHandler(
    logger: ref.watch(loggerProvider),
    errorReporter: ref.watch(errorReporterProvider),
  );
}
