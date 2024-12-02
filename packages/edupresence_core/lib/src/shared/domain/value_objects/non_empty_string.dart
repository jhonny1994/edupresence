import 'package:dartz/dartz.dart';

import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_object.dart';

class NonEmptyString extends ValueObject<String> {
  factory NonEmptyString(String input) {
    return NonEmptyString._(
      _validate(input),
    );
  }

  const NonEmptyString._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  static Either<ValueFailure<String>, String> _validate(String input) {
    if (input.isEmpty) {
      return left(ValueFailure.empty(failedValue: input));
    }

    return right(input.trim());
  }
}
