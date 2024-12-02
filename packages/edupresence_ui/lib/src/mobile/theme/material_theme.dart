import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:edupresence_ui/src/shared/theme/app_theme.dart';
import 'package:edupresence_ui/src/shared/typography.dart';
import 'package:flutter/material.dart';

/// Material theme implementation for the mobile app
class MaterialAppTheme extends AppTheme {
  /// Creates a light material theme
  const MaterialAppTheme.light() : _isDark = false;

  /// Creates a dark material theme
  const MaterialAppTheme.dark() : _isDark = true;

  final bool _isDark;

  @override
  bool get isDark => _isDark;

  @override
  ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
      );

  @override
  TextTheme get textTheme => isDark
      ? AppTypography.textTheme.apply(
          bodyColor: AppColors.textPrimaryDark,
          displayColor: AppColors.textPrimaryDark,
        )
      : AppTypography.textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        );

  @override
  CardTheme get cardTheme => CardTheme(
        elevation: AppTheme.elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        margin: const EdgeInsets.all(AppTheme.spacing8),
      );

  @override
  ButtonThemeData get buttonTheme => ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing8,
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing16,
          vertical: AppTheme.spacing12,
        ),
      );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        elevation: AppTheme.elevationSmall,
        centerTitle: true,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        foregroundColor:
            isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        elevation: AppTheme.elevationSmall,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      );

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
      );

  @override
  DialogTheme get dialogTheme => DialogTheme(
        elevation: AppTheme.elevationLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        elevation: AppTheme.elevationMedium,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusCircular),
        ),
      );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        elevation: AppTheme.elevationLarge,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        behavior: SnackBarBehavior.floating,
      );

  @override
  BottomSheetThemeData get bottomSheetTheme => BottomSheetThemeData(
        elevation: AppTheme.elevationLarge,
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusLarge),
          ),
        ),
      );

  @override
  PopupMenuThemeData get popupMenuTheme => PopupMenuThemeData(
        elevation: AppTheme.elevationMedium,
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
      );

  @override
  DividerThemeData get dividerTheme => DividerThemeData(
        space: AppTheme.spacing16,
        thickness: 1,
        color: isDark ? AppColors.borderDark : AppColors.border,
      );

  @override
  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return isDark ? AppColors.borderDark : AppColors.border;
        }),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppTheme.radiusSmall)),
        ),
      );

  @override
  RadioThemeData get radioTheme => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return isDark ? AppColors.borderDark : AppColors.border;
        }),
      );

  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return isDark ? AppColors.borderDark : AppColors.border;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withOpacity(0.5);
          }
          return isDark
              ? AppColors.borderDark.withOpacity(0.5)
              : AppColors.border.withOpacity(0.5);
        }),
      );

  @override
  SliderThemeData get sliderTheme => SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: isDark
            ? AppColors.borderDark.withOpacity(0.5)
            : AppColors.border.withOpacity(0.5),
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.12),
      );

  @override
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: isDark
            ? AppColors.borderDark.withOpacity(0.5)
            : AppColors.border.withOpacity(0.5),
        circularTrackColor: isDark
            ? AppColors.borderDark.withOpacity(0.5)
            : AppColors.border.withOpacity(0.5),
      );

  /// Converts this theme to a Material ThemeData
  ThemeData toThemeData() => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: textTheme,
        cardTheme: cardTheme,
        buttonTheme: buttonTheme,
        inputDecorationTheme: inputDecorationTheme,
        appBarTheme: appBarTheme,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        tabBarTheme: tabBarTheme,
        dialogTheme: dialogTheme,
        floatingActionButtonTheme: floatingActionButtonTheme,
        snackBarTheme: snackBarTheme,
        bottomSheetTheme: bottomSheetTheme,
        popupMenuTheme: popupMenuTheme,
        dividerTheme: dividerTheme,
        checkboxTheme: checkboxTheme,
        radioTheme: radioTheme,
        switchTheme: switchTheme,
        sliderTheme: sliderTheme,
        progressIndicatorTheme: progressIndicatorTheme,
      );
}
