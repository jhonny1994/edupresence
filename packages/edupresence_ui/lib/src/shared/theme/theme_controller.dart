import 'package:edupresence_ui/src/shared/theme/theme_mode.dart';
import 'package:flutter/material.dart'
    show Brightness, BuildContext, MediaQuery;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme controller for managing theme mode
class ThemeController extends StateNotifier<AppThemeMode> {
  /// Creates a theme controller with system as default theme mode
  ThemeController() : super(AppThemeMode.system) {
    _loadTheme();
  }

  static const _themeKey = 'app_theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString != null) {
      state = AppThemeMode.values.firstWhere(
        (mode) => mode.name == themeString,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  Future<void> _saveTheme(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  /// Get whether the current theme is dark mode
  bool isDarkMode(BuildContext context) {
    if (state == AppThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return state == AppThemeMode.dark;
  }

  /// Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    await _saveTheme(mode);
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final mode =
        state == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
    await setThemeMode(mode);
  }
}
