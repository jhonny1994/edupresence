import 'package:flutter/material.dart';

/// Base theme interface for the application
abstract class AppTheme {
  /// Creates an app theme
  const AppTheme();

  /// Gets whether this theme is dark
  bool get isDark;

  /// Gets the color scheme for this theme
  ColorScheme get colorScheme;

  /// Gets the text theme for this theme
  TextTheme get textTheme;

  /// Gets the primary color
  Color get primaryColor => colorScheme.primary;

  /// Gets the secondary color
  Color get secondaryColor => colorScheme.secondary;

  /// Gets the background color
  Color get backgroundColor => colorScheme.surface;

  /// Gets the surface color
  Color get surfaceColor => colorScheme.surface;

  /// Gets the error color
  Color get errorColor => colorScheme.error;

  /// Gets the text color
  Color get textColor => colorScheme.onSurface;

  /// Gets the primary text color
  Color get primaryTextColor => colorScheme.onPrimary;

  /// Gets the secondary text color
  Color get secondaryTextColor => colorScheme.onSecondary;

  /// Gets the disabled color
  Color get disabledColor => colorScheme.onSurface.withOpacity(0.38);

  /// Gets the divider color
  Color get dividerColor => colorScheme.outline;

  /// Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 400);

  /// Spacing values
  static const double spacing0 = 0;
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing8 = 8;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing56 = 56;
  static const double spacing64 = 64;

  /// Border radius values
  static const double radiusNone = 0;
  static const double radiusSmall = 4;
  static const double radiusMedium = 8;
  static const double radiusLarge = 12;
  static const double radiusXLarge = 16;
  static const double radiusCircular = 999;

  /// Elevation values
  static const double elevationNone = 0;
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 8;
  static const double elevationXLarge = 16;

  /// Icon sizes
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double iconSizeXLarge = 40;

  /// Font sizes
  static const double fontSizeSmall = 12;
  static const double fontSizeMedium = 14;
  static const double fontSizeLarge = 16;
  static const double fontSizeXLarge = 18;

  /// Line heights
  static const double lineHeightSmall = 1.25;
  static const double lineHeightMedium = 1.5;
  static const double lineHeightLarge = 1.75;
  static const double lineHeightXLarge = 2;

  /// Letter spacing
  static const double letterSpacingSmall = -0.25;
  static const double letterSpacingMedium = 0;
  static const double letterSpacingLarge = 0.25;
  static const double letterSpacingXLarge = 0.5;

  /// Component-specific getters
  
  /// Gets the card theme
  CardTheme get cardTheme => const CardTheme();

  /// Gets the button theme
  ButtonThemeData get buttonTheme => const ButtonThemeData();

  /// Gets the input decoration theme
  InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme();

  /// Gets the app bar theme
  AppBarTheme get appBarTheme => const AppBarTheme();

  /// Gets the bottom navigation bar theme
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData();

  /// Gets the tab bar theme
  TabBarTheme get tabBarTheme => const TabBarTheme();

  /// Gets the dialog theme
  DialogTheme get dialogTheme => const DialogTheme();

  /// Gets the floating action button theme
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      const FloatingActionButtonThemeData();

  /// Gets the snack bar theme
  SnackBarThemeData get snackBarTheme => const SnackBarThemeData();

  /// Gets the bottom sheet theme
  BottomSheetThemeData get bottomSheetTheme => const BottomSheetThemeData();

  /// Gets the popup menu theme
  PopupMenuThemeData get popupMenuTheme => const PopupMenuThemeData();

  /// Gets the divider theme
  DividerThemeData get dividerTheme => const DividerThemeData();

  /// Gets the checkbox theme
  CheckboxThemeData get checkboxTheme => const CheckboxThemeData();

  /// Gets the radio theme
  RadioThemeData get radioTheme => const RadioThemeData();

  /// Gets the switch theme
  SwitchThemeData get switchTheme => const SwitchThemeData();

  /// Gets the slider theme
  SliderThemeData get sliderTheme => const SliderThemeData();

  /// Gets the progress indicator theme
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      const ProgressIndicatorThemeData();
}
