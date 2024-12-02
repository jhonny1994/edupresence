import 'package:edupresence_core/src/shared/domain/value_objects/email_address.dart';
import 'package:edupresence_core/src/shared/domain/value_objects/unique_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required UniqueId id,
    required EmailAddress email,
    required String name,
    required String role,
  }) = _User;
}
