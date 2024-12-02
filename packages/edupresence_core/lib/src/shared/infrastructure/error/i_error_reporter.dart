/// Interface for error reporting functionality
abstract class IErrorReporter {
  /// Report a non-fatal error
  Future<void> reportError(dynamic error, StackTrace stackTrace);

  /// Report a fatal error that crashes the app
  Future<void> reportFatalError(dynamic error, StackTrace stackTrace);

  /// Set user identifier for error reports
  Future<void> setUserId(String userId);

  /// Add custom key-value data to error reports
  Future<void> setCustomKey(String key, dynamic value);
}
