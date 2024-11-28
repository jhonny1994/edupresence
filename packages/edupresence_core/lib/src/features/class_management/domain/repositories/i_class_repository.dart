import 'package:dartz/dartz.dart';

import 'package:edupresence_core/src/features/class_management/domain/entities/class.dart';
import 'package:edupresence_core/src/features/class_management/domain/repositories/class_failure.dart';

abstract class IClassRepository {
  Stream<Either<ClassFailure, List<Class>>> watchProfessorClasses(
    String professorId,
  );
  Stream<Either<ClassFailure, List<Class>>> watchStudentClasses(
    String studentId,
  );

  Future<Either<ClassFailure, Class>> getClass(String classId);

  Future<Either<ClassFailure, Unit>> createClass(Class classData);
  Future<Either<ClassFailure, Unit>> updateClass(Class classData);
  Future<Either<ClassFailure, Unit>> deleteClass(String classId);

  Future<Either<ClassFailure, Unit>> enrollStudent({
    required String classId,
    required String studentId,
  });

  Future<Either<ClassFailure, Unit>> unenrollStudent({
    required String classId,
    required String studentId,
  });
}
