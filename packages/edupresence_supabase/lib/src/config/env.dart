import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration for the application
class Env {
  /// Private constructor to prevent instantiation
  const Env._();

  /// Load environment variables from .env file
  static Future<void> load() async {
    await dotenv.load();
  }

  /// Supabase project URL from environment
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  /// Supabase anonymous key from environment
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  /// Check if all required environment variables are set
  static bool get hasValidConfig {
    try {
      return supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
