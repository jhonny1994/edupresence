import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography
class AppTypography {
  /// Creates the base text theme using Inter font
  static TextTheme get textTheme => GoogleFonts.interTextTheme();

  /// Large display text style
  static TextStyle get displayLarge => textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      );

  /// Medium display text style
  static TextStyle get displayMedium => textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );

  /// Small display text style
  static TextStyle get displaySmall => textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w400,
      );

  /// Large headline text style
  static TextStyle get headlineLarge => textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  /// Medium headline text style
  static TextStyle get headlineMedium => textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w400,
      );

  /// Small headline text style
  static TextStyle get headlineSmall => textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w400,
      );

  /// Large title text style
  static TextStyle get titleLarge => textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  /// Medium title text style
  static TextStyle get titleMedium => textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      );

  /// Small title text style
  static TextStyle get titleSmall => textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  /// Large body text style
  static TextStyle get bodyLarge => textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );

  /// Medium body text style
  static TextStyle get bodyMedium => textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  /// Small body text style
  static TextStyle get bodySmall => textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      );

  /// Label text style
  static TextStyle get labelLarge => textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      );
}
