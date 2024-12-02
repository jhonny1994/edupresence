import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography styles for the application
abstract class AppTypography {
  /// Base text theme
  static TextTheme get textTheme => GoogleFonts.interTextTheme();

  /// Display large text style
  static TextStyle get displayLarge => textTheme.displayLarge!.copyWith(
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      );

  /// Display medium text style
  static TextStyle get displayMedium => textTheme.displayMedium!.copyWith(
        fontSize: 45,
        height: 1.16,
      );

  /// Display small text style
  static TextStyle get displaySmall => textTheme.displaySmall!.copyWith(
        fontSize: 36,
        height: 1.22,
      );

  /// Headline large text style
  static TextStyle get headlineLarge => textTheme.headlineLarge!.copyWith(
        fontSize: 32,
        height: 1.25,
      );

  /// Headline medium text style
  static TextStyle get headlineMedium => textTheme.headlineMedium!.copyWith(
        fontSize: 28,
        height: 1.29,
      );

  /// Headline small text style
  static TextStyle get headlineSmall => textTheme.headlineSmall!.copyWith(
        fontSize: 24,
        height: 1.33,
      );

  /// Title large text style
  static TextStyle get titleLarge => textTheme.titleLarge!.copyWith(
        fontSize: 22,
        height: 1.27,
      );

  /// Title medium text style
  static TextStyle get titleMedium => textTheme.titleMedium!.copyWith(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      );

  /// Title small text style
  static TextStyle get titleSmall => textTheme.titleSmall!.copyWith(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      );

  /// Label large text style
  static TextStyle get labelLarge => textTheme.labelLarge!.copyWith(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      );

  /// Label medium text style
  static TextStyle get labelMedium => textTheme.labelMedium!.copyWith(
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      );

  /// Label small text style
  static TextStyle get labelSmall => textTheme.labelSmall!.copyWith(
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      );

  /// Body large text style
  static TextStyle get bodyLarge => textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      );

  /// Body medium text style
  static TextStyle get bodyMedium => textTheme.bodyMedium!.copyWith(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.25,
      );

  /// Body small text style
  static TextStyle get bodySmall => textTheme.bodySmall!.copyWith(
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      );
}
