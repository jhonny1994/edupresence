import 'package:edupresence_ui/src/shared/theme/theme_controller.dart';
import 'package:edupresence_ui/src/shared/theme/theme_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme controller provider
final themeControllerProvider =
    StateNotifierProvider<ThemeController, AppThemeMode>(
  (ref) => ThemeController(),
);
