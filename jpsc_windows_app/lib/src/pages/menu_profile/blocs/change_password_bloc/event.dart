part of 'bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordFieldChanged extends ChangePasswordEvent {
  final String value;

  const PasswordFieldChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class ConfirmPasswordFieldChanged extends ChangePasswordEvent {
  final String value;

  const ConfirmPasswordFieldChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class ButtonSubmitted extends ChangePasswordEvent {}
