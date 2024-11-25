library edupresence_supabase;

export 'src/auth/auth_repository.dart';
export 'src/database/database_repository.dart';
export 'src/env.dart';
export 'src/supabase_client.dart';
export 'src/supabase_client_provider.dart';

// Export only what we need from supabase_flutter
export 'package:supabase_flutter/supabase_flutter.dart'
    show User, AuthException, AuthState;
