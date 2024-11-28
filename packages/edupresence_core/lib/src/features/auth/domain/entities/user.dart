import 'package:edupresence_core/src/shared/domain/enums/user_role.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/email_address.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/non_empty_string.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/unique_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required UniqueId id,
    required EmailAddress email,
    required NonEmptyString fullName,
    required UserRole role,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;
}
