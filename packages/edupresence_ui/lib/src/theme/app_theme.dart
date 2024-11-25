import 'package:edupresence_ui/src/theme/app_colors.dart';
import 'package:edupresence_ui/src/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// App theme data
class AppTheme {
  /// Light theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.lightColorScheme,
        textTheme: AppTypography.textTheme,
        scaffoldBackgroundColor: AppColors.surface1,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.lightColorScheme.surface,
          foregroundColor: AppColors.lightColorScheme.onSurface,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.lightColorScheme.primary,
            foregroundColor: AppColors.lightColorScheme.onPrimary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: AppColors.lightColorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.lightColorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.lightColorScheme.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: AppColors.lightColorScheme.onSurfaceVariant,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.lightColorScheme.outlineVariant,
          space: 1,
          thickness: 1,
        ),
      );

  /// Dark theme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.darkColorScheme,
        textTheme: AppTypography.textTheme,
        scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.darkColorScheme.surface,
          foregroundColor: AppColors.darkColorScheme.onSurface,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: AppColors.darkColorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.darkColorScheme.primary,
            foregroundColor: AppColors.darkColorScheme.onPrimary,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: AppColors.darkColorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.darkColorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.darkColorScheme.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: AppColors.darkColorScheme.onSurfaceVariant,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.darkColorScheme.outlineVariant,
          space: 1,
          thickness: 1,
        ),
      );
}
