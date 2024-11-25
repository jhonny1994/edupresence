import 'package:edupresence_supabase/edupresence_supabase.dart';
import 'package:riverpod/riverpod.dart';

/// Repository provider for database operations
final databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return DatabaseRepository(client);
});

/// Provider for user profile data
final userProfileProvider = FutureProvider.family<Map<String, dynamic>?, String>(
  (ref, userId) async {
    final repository = ref.watch(databaseRepositoryProvider);
    return repository.getProfile(userId);
  },
);

/// Provider for professor's classes
final professorClassesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, professorId) async {
    final repository = ref.watch(databaseRepositoryProvider);
    return repository.getProfessorClasses(professorId);
  },
);

/// Provider for student's enrolled classes
final studentClassesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, studentId) async {
    final repository = ref.watch(databaseRepositoryProvider);
    return repository.getStudentClasses(studentId);
  },
);

/// Provider for student's attendance history
final studentAttendanceHistoryProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, studentId) async {
    final repository = ref.watch(databaseRepositoryProvider);
    return repository.getStudentAttendanceHistory(studentId);
  },
);
