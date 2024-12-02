import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';

/// A collection of reusable validators
class Validators {
  const Validators._();

  /// Validates an email address
  static Either<ValueFailure<String>, String> validateEmail(String input) {
    const emailRegex =
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    if (RegExp(emailRegex).hasMatch(input)) {
      return right(input);
    } else {
      return left(ValueFailure.invalidEmail(failedValue: input));
    }
  }

  /// Validates a string is not empty
  static Either<ValueFailure<String>, String> validateNotEmpty(String input) {
    if (input.isEmpty) {
      return left(ValueFailure.empty(failedValue: input));
    } else {
      return right(input);
    }
  }

  /// Validates a string length is within bounds
  static Either<ValueFailure<String>, String> validateLength(
    String input,
    int minLength,
    int maxLength,
  ) {
    if (input.length < minLength) {
      return left(
        ValueFailure.shortInput(
          failedValue: input,
          minLength: minLength,
        ),
      );
    } else if (input.length > maxLength) {
      return left(
        ValueFailure.exceedingLength(
          failedValue: input,
          maxLength: maxLength,
        ),
      );
    } else {
      return right(input);
    }
  }

  /// Validates a string matches a pattern
  static Either<ValueFailure<String>, String> validatePattern(
    String input,
    RegExp pattern,
    String failureType,
  ) {
    if (pattern.hasMatch(input)) {
      return right(input);
    } else {
      return left(
        ValueFailure.invalidPattern(
          failedValue: input,
          pattern: pattern.pattern,
          type: failureType,
        ),
      );
    }
  }

  /// Validates a numeric value is within bounds
  static Either<ValueFailure<num>, num> validateNumericBounds(
    num input,
    num min,
    num max,
  ) {
    if (input < min) {
      return left(
        ValueFailure.numberTooLow(
          failedValue: input,
          min: min,
        ),
      );
    } else if (input > max) {
      return left(
        ValueFailure.numberTooHigh(
          failedValue: input,
          max: max,
        ),
      );
    } else {
      return right(input);
    }
  }
}
