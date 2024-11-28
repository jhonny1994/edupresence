import 'package:edupresence_core/src/shared/domain/value_objects/non_empty_string.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/unique_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class.freezed.dart';

@freezed
class Class with _$Class {
  const factory Class({
    required UniqueId id,
    required NonEmptyString name,
    required NonEmptyString code,
    required UniqueId professorId,
    required NonEmptyString semester,
    required int year,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Class;
}
