import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  /// App color scheme for light theme
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A6EBD), // Deep Professional Blue
      );

  /// App color scheme for dark theme
  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A6EBD), // Deep Professional Blue
        brightness: Brightness.dark,
      );

  /// Custom colors that complement the theme
  static const Color success = Color(0xFF43A047); // Success Green
  static const Color warning = Color(0xFFFFA000); // Warning Amber
  static const Color info = Color(0xFF2196F3); // Info Blue
  static const Color surface1 = Color(0xFFF8F9FA); // Light Surface
  static const Color surface2 = Color(0xFFF1F3F4); // Medium Surface
  static const Color surface3 = Color(0xFFE8EAED); // Dark Surface
}
