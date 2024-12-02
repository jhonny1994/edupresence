import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:edupresence_ui/src/shared/theme/app_theme.dart';
import 'package:edupresence_ui/src/shared/typography.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart'
    show Border, BorderRadius, Brightness, ColorScheme, Colors, TextTheme;

/// Fluent theme implementation for the desktop app
class FluentAppTheme extends AppTheme {
  /// Creates a light fluent theme
  const FluentAppTheme.light() : _isDark = false;

  /// Creates a dark fluent theme
  const FluentAppTheme.dark() : _isDark = true;

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

  /// Gets the Fluent UI theme data
  fluent.FluentThemeData toThemeData() {
    final accentColor = fluent.AccentColor('custom', const {
      'darkest': AppColors.primary,
      'darker': AppColors.primary,
      'dark': AppColors.primary,
      'normal': AppColors.primary,
      'light': AppColors.primary,
      'lighter': AppColors.primary,
      'lightest': AppColors.primary,
    });

    return fluent.FluentThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      accentColor: accentColor,
      visualDensity: fluent.VisualDensity.standard,
      focusTheme: fluent.FocusThemeData(
        glowColor: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      buttonTheme: fluent.ButtonThemeData(
        defaultButtonStyle: fluent.ButtonStyle(
          padding: fluent.WidgetStateProperty.all(
            const fluent.EdgeInsets.symmetric(
              horizontal: AppTheme.spacing16,
              vertical: AppTheme.spacing8,
            ),
          ),
          backgroundColor: fluent.WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return isDark
                  ? AppColors.borderDark.withOpacity(0.5)
                  : AppColors.border.withOpacity(0.5);
            }
            if (states.isPressed) {
              return AppColors.primary;
            }
            if (states.isHovered) {
              return AppColors.primary;
            }
            return AppColors.primary;
          }),
          foregroundColor: fluent.WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary;
            }
            return AppColors.textPrimaryDark;
          }),
        ),
      ),
      navigationPaneTheme: fluent.NavigationPaneThemeData(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        highlightColor: AppColors.primary.withOpacity(0.12),
        selectedIconColor: fluent.WidgetStateProperty.all(AppColors.primary),
        unselectedIconColor: fluent.WidgetStateProperty.all(
          isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
        selectedTextStyle: fluent.WidgetStateProperty.all(
          textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
          ),
        ),
        unselectedTextStyle: fluent.WidgetStateProperty.all(
          textTheme.titleSmall?.copyWith(
            color:
                isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
      ),
      tooltipTheme: fluent.TooltipThemeData(
        decoration: fluent.BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.border,
          ),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),
      dialogTheme: fluent.ContentDialogThemeData(
        decoration: fluent.BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        titleStyle: textTheme.titleLarge?.copyWith(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
        bodyStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),
      ),
      checkboxTheme: fluent.CheckboxThemeData(
        checkedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return const fluent.BoxDecoration(
              color: Colors.transparent,
            );
          }
          return const fluent.BoxDecoration(
            color: AppColors.primary,
          );
        }),
        uncheckedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return fluent.BoxDecoration(
              color: isDark
                  ? AppColors.borderDark.withOpacity(0.5)
                  : AppColors.border.withOpacity(0.5),
            );
          }
          return fluent.BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.border,
            ),
          );
        }),
      ),
      radioButtonTheme: fluent.RadioButtonThemeData(
        checkedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return const fluent.BoxDecoration(
              color: Colors.transparent,
            );
          }
          return const fluent.BoxDecoration(
            color: AppColors.primary,
          );
        }),
        uncheckedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return fluent.BoxDecoration(
              color: isDark
                  ? AppColors.borderDark.withOpacity(0.5)
                  : AppColors.border.withOpacity(0.5),
            );
          }
          return fluent.BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.border,
            ),
          );
        }),
      ),
      toggleSwitchTheme: fluent.ToggleSwitchThemeData(
        checkedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return const fluent.BoxDecoration(
              color: Colors.transparent,
            );
          }
          return const fluent.BoxDecoration(
            color: AppColors.primary,
          );
        }),
        uncheckedDecoration: fluent.WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return fluent.BoxDecoration(
              color: isDark
                  ? AppColors.borderDark.withOpacity(0.5)
                  : AppColors.border.withOpacity(0.5),
            );
          }
          return fluent.BoxDecoration(
            color: isDark ? AppColors.borderDark : AppColors.border,
          );
        }),
      ),
      sliderTheme: fluent.SliderThemeData(
        activeColor: fluent.WidgetStateProperty.all(AppColors.primary),
        inactiveColor: fluent.WidgetStateProperty.all(
          isDark
              ? AppColors.borderDark.withOpacity(0.5)
              : AppColors.border.withOpacity(0.5),
        ),
      ),
    );
  }
}
