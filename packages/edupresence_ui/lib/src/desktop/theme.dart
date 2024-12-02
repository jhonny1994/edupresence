import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart' show VisualDensity;

/// Desktop theme for the application using Fluent UI
class DesktopTheme {
  /// Get the light theme data
  static fluent.FluentThemeData get light =>
      fluent.FluentThemeData.light().copyWith(
        accentColor: fluent.AccentColor.swatch(const {
          'darkest': fluent.Color(0xff004881),
          'darker': fluent.Color(0xff0067b8),
          'dark': fluent.Color(0xff1976d2),
          'normal': AppColors.primary,
          'light': fluent.Color(0xff4d94ff),
          'lighter': fluent.Color(0xff80b3ff),
          'lightest': fluent.Color(0xffb3d1ff),
        }),
        visualDensity: VisualDensity.standard,
        focusTheme: fluent.FocusThemeData(
          glowColor: AppColors.primary.withOpacity(0.1),
          glowFactor: 0,
          primaryBorder: const fluent.BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        resources: fluent.ResourceDictionary.light(
          cardBackgroundFillColorDefault: AppColors.surface,
          cardBackgroundFillColorSecondary: AppColors.surface.withOpacity(0.5),
          controlStrokeColorDefault: AppColors.border,
          controlStrokeColorSecondary: AppColors.border.withOpacity(0.5),
        ),
      );

  /// Get the dark theme data
  static fluent.FluentThemeData get dark =>
      fluent.FluentThemeData.dark().copyWith(
        accentColor: fluent.AccentColor.swatch(const {
          'darkest': fluent.Color(0xff004881),
          'darker': fluent.Color(0xff0067b8),
          'dark': fluent.Color(0xff1976d2),
          'normal': AppColors.primary,
          'light': fluent.Color(0xff4d94ff),
          'lighter': fluent.Color(0xff80b3ff),
          'lightest': fluent.Color(0xffb3d1ff),
        }),
        visualDensity: VisualDensity.standard,
        focusTheme: fluent.FocusThemeData(
          glowColor: AppColors.primary.withOpacity(0.1),
          glowFactor: 0,
          primaryBorder: const fluent.BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        resources: fluent.ResourceDictionary.dark(
          cardBackgroundFillColorDefault: AppColors.surfaceDark,
          cardBackgroundFillColorSecondary:
              AppColors.surfaceDark.withOpacity(0.5),
          controlStrokeColorDefault: AppColors.borderDark,
          controlStrokeColorSecondary: AppColors.borderDark.withOpacity(0.5),
        ),
      );
}
