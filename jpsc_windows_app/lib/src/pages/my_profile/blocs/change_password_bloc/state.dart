part of 'bloc.dart';

class ChangePasswordState extends Equatable {
  final FormzStatus status;
  final FormzString password;
  final FormzString confirmPassword;
  final String message;

  const ChangePasswordState(
      {this.status = FormzStatus.pure,
      this.password = const FormzString.pure(),
      this.confirmPassword = const FormzString.pure(),
      this.message = ""});

  ChangePasswordState copyWith({
    FormzStatus? status,
    FormzString? password,
    FormzString? confirmPassword,
    String? message,
  }) =>
      ChangePasswordState(
          status: status ?? this.status,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          message: message ?? this.message);

  @override
  List<Object?> get props => [status, password, confirmPassword, message];
}
