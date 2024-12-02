/// Application-wide constants
class AppConstants {
  const AppConstants._();

  /// Authentication related constants
  static const authTimeout = Duration(seconds: 30);
  static const minPasswordLength = 8;
  static const maxPasswordLength = 32;
  static const maxNameLength = 50;
  static const maxEmailLength = 254; // RFC 5321
  
  /// API related constants
  static const apiTimeout = Duration(seconds: 30);
  static const maxRetries = 3;
  
  /// UI related constants
  static const animationDuration = Duration(milliseconds: 300);
  static const snackBarDuration = Duration(seconds: 4);
}
