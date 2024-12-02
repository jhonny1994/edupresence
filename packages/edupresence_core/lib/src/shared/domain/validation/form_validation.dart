import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_object.dart';

/// A utility class for form validation
class FormValidation {
  const FormValidation._();

  /// Validates a list of value objects and returns a list of failures if any
  static List<ValueFailure<dynamic>> validateAll(List<ValueObject<dynamic>> fields) {
    return fields
        .map((field) => field.value)
        .where((value) => value.isLeft())
        .map((value) => value.fold((l) => l, (r) => throw Error()))
        .toList();
  }

  /// Checks if all fields are valid
  static bool validateForm(List<ValueObject<dynamic>> fields) {
    return fields.every((field) => field.isValid());
  }

  /// Combines multiple value objects into a single Either
  /// Returns Right(Unit) if all are valid, otherwise returns the first failure
  static Either<ValueFailure<dynamic>, Unit> combine(List<ValueObject<dynamic>> fields) {
    for (final field in fields) {
      final failureOrSuccess = field.value;
      if (failureOrSuccess.isLeft()) {
        return left(failureOrSuccess.fold((l) => l, (r) => throw Error()));
      }
    }
    return right(unit);
  }

  /// Returns a map of field names to their validation failures
  static Map<String, ValueFailure<dynamic>> getFieldErrors(
    Map<String, ValueObject<dynamic>> fields,
  ) {
    return Map.fromEntries(
      fields.entries.where((entry) => !entry.value.isValid()).map(
            (entry) => MapEntry(
              entry.key,
              entry.value.value.fold((l) => l, (r) => throw Error()),
            ),
          ),
    );
  }
}
