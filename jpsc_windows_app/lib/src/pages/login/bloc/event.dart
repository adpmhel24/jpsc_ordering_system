part of 'bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final TextEditingController emailController;
  const EmailChanged(this.emailController);
  @override
  List<Object> get props => [emailController];
}

class PasswordChanged extends LoginEvent {
  final TextEditingController passwordController;
  const PasswordChanged(this.passwordController);
  @override
  List<Object> get props => [passwordController];
}
