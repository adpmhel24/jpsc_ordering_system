part of 'bloc.dart';

abstract class SystemUserFormEvent extends Equatable {
  const SystemUserFormEvent();
  @override
  List<Object> get props => [];
}

class FirstNameChanged extends SystemUserFormEvent {
  final TextEditingController firstNameController;
  const FirstNameChanged(this.firstNameController);
  @override
  List<Object> get props => [firstNameController];
}

class LastNameChanged extends SystemUserFormEvent {
  final TextEditingController lastNameController;
  const LastNameChanged(this.lastNameController);
  @override
  List<Object> get props => [lastNameController];
}

class EmailChanged extends SystemUserFormEvent {
  final TextEditingController emailController;
  const EmailChanged(this.emailController);
  @override
  List<Object> get props => [emailController];
}

class PasswordChanged extends SystemUserFormEvent {
  final TextEditingController passwordController;
  const PasswordChanged(this.passwordController);
  @override
  List<Object> get props => [passwordController];
}

class PositionCodeChanged extends SystemUserFormEvent {
  final TextEditingController positionCode;
  const PositionCodeChanged(this.positionCode);

  @override
  List<Object> get props => [positionCode];
}

class CreateButtonSubmitted extends SystemUserFormEvent {}

class UpdateButtonSubmitted extends SystemUserFormEvent {}
