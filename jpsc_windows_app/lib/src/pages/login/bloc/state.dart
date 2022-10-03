part of 'bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final FormzEmail email;
  final FormzString password;
  final String? message;

  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const FormzEmail.pure(),
    this.password = const FormzString.pure(),
    this.message = '',
  });

  LoginState copyWith({
    FormzStatus? status,
    FormzEmail? email,
    FormzString? password,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
      ];
}
