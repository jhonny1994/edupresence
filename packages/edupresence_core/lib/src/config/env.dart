/// Environment configuration
class Env {
  const Env._();

  /// Whether the app is running in debug mode
  static bool get isDebug {
    var isDebug = false;
    assert(
      () {
        isDebug = true;
        return true;
      }(),
      'Debug mode check',
    );
    return isDebug;
  }

  /// Whether the app is running in release mode
  static bool get isRelease => !isDebug;
}
