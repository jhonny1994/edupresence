import 'package:supabase_flutter/supabase_flutter.dart';

/// Base repository class that provides the Supabase client
abstract class BaseRepository {
  /// Creates a new [BaseRepository] instance with the given [client]
  const BaseRepository(this.client);

  /// The Supabase client used to interact with the database
  final SupabaseClient client;
}
