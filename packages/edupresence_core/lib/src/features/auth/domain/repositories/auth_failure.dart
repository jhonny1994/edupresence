import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination;
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  const factory AuthFailure.authServerError() = AuthServerError;
  const factory AuthFailure.weakPassword() = WeakPassword;
  const factory AuthFailure.authInvalidEmail() = AuthInvalidEmail;
  const factory AuthFailure.networkError() = NetworkError;
  const factory AuthFailure.emailNotVerified() = EmailNotVerified;
  const factory AuthFailure.tooManyRequests() = TooManyRequests;
}
