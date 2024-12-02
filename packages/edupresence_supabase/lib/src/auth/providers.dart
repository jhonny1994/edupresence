import 'package:edupresence_core/edupresence_core.dart';
import 'package:edupresence_supabase/src/auth/supabase_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Override for the auth repository provider
final authRepositoryOverride = Provider<IAuthRepository>(
  (ref) {
    final supabase = Supabase.instance.client;
    return SupabaseAuthRepository(supabase);
  },
);
