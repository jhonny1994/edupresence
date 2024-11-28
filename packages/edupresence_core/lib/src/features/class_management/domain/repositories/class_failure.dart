import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_failure.freezed.dart';

@freezed
class ClassFailure with _$ClassFailure {
  const factory ClassFailure.classServerError() = ClassServerError;
  const factory ClassFailure.classInsufficientPermission() = ClassInsufficientPermission;
  const factory ClassFailure.classNotFound() = ClassNotFound;
  const factory ClassFailure.studentAlreadyEnrolled() = StudentAlreadyEnrolled;
  const factory ClassFailure.studentNotEnrolledInClass() = StudentNotEnrolledInClass;
  const factory ClassFailure.classCodeAlreadyExists() = ClassCodeAlreadyExists;
}
