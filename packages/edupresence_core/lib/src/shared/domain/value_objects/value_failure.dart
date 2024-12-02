import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;

  const factory ValueFailure.invalidPhoneNumber({
    required String failedValue,
  }) = InvalidPhoneNumber<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int maxLength,
  }) = ExceedingLength<T>;

  const factory ValueFailure.shortInput({
    required T failedValue,
    required int minLength,
  }) = ShortInput<T>;

  const factory ValueFailure.invalidCharacters({
    required T failedValue,
  }) = InvalidCharacters<T>;

  const factory ValueFailure.missingUppercase({
    required String failedValue,
  }) = MissingUppercase<T>;

  const factory ValueFailure.missingLowercase({
    required String failedValue,
  }) = MissingLowercase<T>;

  const factory ValueFailure.missingNumber({
    required String failedValue,
  }) = MissingNumber<T>;

  const factory ValueFailure.missingSpecialCharacter({
    required String failedValue,
  }) = MissingSpecialCharacter<T>;

  const factory ValueFailure.invalidPattern({
    required T failedValue,
    required String pattern,
    required String type,
  }) = InvalidPattern<T>;

  const factory ValueFailure.numberTooLow({
    required num failedValue,
    required num min,
  }) = NumberTooLow<T>;

  const factory ValueFailure.numberTooHigh({
    required num failedValue,
    required num max,
  }) = NumberTooHigh<T>;
}
