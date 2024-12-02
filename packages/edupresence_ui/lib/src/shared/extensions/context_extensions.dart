import 'package:flutter/material.dart';

/// Extensions on [BuildContext]
extension BuildContextX on BuildContext {
  /// Get the theme
  ThemeData get theme => Theme.of(this);

  /// Get the color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get the media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get the screen size
  Size get screenSize => mediaQuery.size;

  /// Get the screen width
  double get screenWidth => screenSize.width;

  /// Get the screen height
  double get screenHeight => screenSize.height;

  /// Get the padding
  EdgeInsets get padding => mediaQuery.padding;

  /// Get the view insets
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Get the view padding
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  /// Get the device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Get the orientation
  Orientation get orientation => mediaQuery.orientation;

  /// Check if the screen is in landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// Check if the screen is in portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if the platform is iOS
  bool get isIOS => theme.platform == TargetPlatform.iOS;

  /// Check if the platform is Android
  bool get isAndroid => theme.platform == TargetPlatform.android;

  /// Check if the platform is Windows
  bool get isWindows => theme.platform == TargetPlatform.windows;

  /// Check if the platform is macOS
  bool get isMacOS => theme.platform == TargetPlatform.macOS;

  /// Check if the platform is Linux
  bool get isLinux => theme.platform == TargetPlatform.linux;

  /// Check if the platform is desktop
  bool get isDesktop => isWindows || isMacOS || isLinux;

  /// Check if the platform is mobile
  bool get isMobile => isIOS || isAndroid;

  /// Show a snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Show a modal bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      shape: shape,
      builder: (context) => child,
    );
  }

  /// Show a dialog
  Future<T?> showAppDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => child,
    );
  }
}
