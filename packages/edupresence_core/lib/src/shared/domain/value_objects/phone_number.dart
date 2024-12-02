import 'package:dartz/dartz.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_failure.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/value_object.dart';

/// A value object representing a phone number
/// Supports international phone numbers in E.164 format
class PhoneNumber extends ValueObject<String> {
  factory PhoneNumber(String input) {
    return PhoneNumber._(
      _validate(input),
    );
  }

  const PhoneNumber._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

  static Either<ValueFailure<String>, String> _validate(String input) {
    // Remove all whitespace and special characters except + for international prefix
    final cleanedInput = input.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanedInput.isEmpty) {
      return left(ValueFailure.empty(failedValue: input));
    }

    // Basic E.164 format validation
    // Should start with optional + followed by digits
    // Length should be between 8 and 15 characters (excluding +)
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    
    if (!phoneRegex.hasMatch(cleanedInput)) {
      return left(ValueFailure.invalidPhoneNumber(failedValue: input));
    }

    // Ensure the number starts with + for international format
    final formattedNumber = cleanedInput.startsWith('+') 
        ? cleanedInput 
        : '+$cleanedInput';

    return right(formattedNumber);
  }

  /// Returns a formatted version of the phone number for display
  /// Example: +1 (234) 567-8900
  String? get formatted {
    return value.fold(
      (l) => null,
      (r) {
        if (r.length < 10) return r;
        
        // Remove the + prefix for formatting
        final digits = r.startsWith('+') ? r.substring(1) : r;
        
        // Format based on length
        if (digits.length == 10) {
          // US format: (123) 456-7890
          return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
        } else {
          // International format: +1 (234) 567-8900
          return '+${digits.substring(0, digits.length - 10)} '
              '(${digits.substring(digits.length - 10, digits.length - 7)}) '
              '${digits.substring(digits.length - 7, digits.length - 4)}-'
              '${digits.substring(digits.length - 4)}';
        }
      },
    );
  }
}
