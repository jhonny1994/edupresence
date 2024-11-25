import 'package:supabase_flutter/supabase_flutter.dart';
import 'env.dart';

class SupabaseClient {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
  }

  static SupabaseClient get instance => _instance;
  static final SupabaseClient _instance = SupabaseClient._();
  SupabaseClient._();

  final _client = Supabase.instance.client;

  GoTrueClient get auth => _client.auth;
  SupabaseQueryBuilder get users => _client.from('profiles');
  SupabaseQueryBuilder get classes => _client.from('classes');
  SupabaseQueryBuilder get attendanceSessions =>
      _client.from('attendance_sessions');
  SupabaseQueryBuilder get attendanceRecords =>
      _client.from('attendance_records');
}
