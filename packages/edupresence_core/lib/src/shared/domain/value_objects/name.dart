import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/config/constants.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_object.dart';

/// A value object representing a person's name
class Name extends ValueObject<String> {
  factory Name(String input) {
    return Name._(
      _validate(input),
    );
  }

  const Name._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  static Either<ValueFailure<String>, String> _validate(String input) {
    if (input.isEmpty) {
      return left(ValueFailure.empty(failedValue: input));
    }

    if (input.length > AppConstants.maxNameLength) {
      return left(
        ValueFailure.exceedingLength(
          failedValue: input,
          maxLength: AppConstants.maxNameLength,
        ),
      );
    }

    // Name should only contain letters, spaces, hyphens, and apostrophes
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(input)) {
      return left(ValueFailure.invalidCharacters(failedValue: input));
    }

    return right(input.trim());
  }
}
