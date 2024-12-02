import 'package:dartz/dartz.dart';

import 'package:edupresence_core/src/config/constants.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_object.dart';

/// A value object representing a password with validation rules
class Password extends ValueObject<String> {
  factory Password(String input) {
    return Password._(
      _validatePassword(input),
    );
  }

  const Password._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  static Either<ValueFailure<String>, String> _validatePassword(String input) {
    if (input.isEmpty) {
      return left(ValueFailure.empty(failedValue: input));
    }

    if (input.length < AppConstants.minPasswordLength) {
      return left(ValueFailure.shortPassword(failedValue: input));
    }

    if (input.length > AppConstants.maxPasswordLength) {
      return left(
        ValueFailure.exceedingLength(
          failedValue: input,
          maxLength: AppConstants.maxPasswordLength,
        ),
      );
    }

    // Password should contain at least one uppercase letter
    if (!input.contains(RegExp('[A-Z]'))) {
      return left(ValueFailure.missingUppercase(failedValue: input));
    }

    // Password should contain at least one lowercase letter
    if (!input.contains(RegExp('[a-z]'))) {
      return left(ValueFailure.missingLowercase(failedValue: input));
    }

    // Password should contain at least one number
    if (!input.contains(RegExp('[0-9]'))) {
      return left(ValueFailure.missingNumber(failedValue: input));
    }

    // Password should contain at least one special character
    if (!input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return left(ValueFailure.missingSpecialCharacter(failedValue: input));
    }

    return right(input);
  }
}
