import 'package:edupresence_supabase/src/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Singleton class to manage Supabase configuration and initialization
class SupabaseConfig {
  SupabaseConfig._();
  static final SupabaseConfig instance = SupabaseConfig._();

  /// Initialize Supabase client using environment variables
  Future<void> initialize() async {
    // Load environment variables
    await Env.load();

    if (!Env.hasValidConfig) {
      throw Exception(
        'Missing Supabase configuration. '
        'Make sure SUPABASE_URL and SUPABASE_ANON_KEY are set in .env file.',
      );
    }

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
  }
}
