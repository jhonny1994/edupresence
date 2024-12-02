import 'package:edupresence_core/src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/// Provider for the auth repository
/// This should be overridden by the implementation package (e.g. edupresence_supabase)
@riverpod
IAuthRepository authRepository(Ref ref) {
  throw UnimplementedError('Provide an auth repository implementation');
}
