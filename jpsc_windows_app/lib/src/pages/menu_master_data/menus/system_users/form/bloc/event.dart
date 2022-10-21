part of 'bloc.dart';

abstract class SystemUserFormEvent extends Equatable {
  const SystemUserFormEvent();
  @override
  List<Object> get props => [];
}

class FirstNameChanged extends SystemUserFormEvent {
  final String value;
  const FirstNameChanged(this.value);
  @override
  List<Object> get props => [value];
}

class LastNameChanged extends SystemUserFormEvent {
  final String value;
  const LastNameChanged(this.value);
  @override
  List<Object> get props => [value];
}

class EmailChanged extends SystemUserFormEvent {
  final String value;
  const EmailChanged(this.value);
  @override
  List<Object> get props => [value];
}

class PasswordChanged extends SystemUserFormEvent {
  final String value;
  const PasswordChanged(this.value);
  @override
  List<Object> get props => [value];
}

class PositionCodeChanged extends SystemUserFormEvent {
  final String value;
  const PositionCodeChanged(this.value);

  @override
  List<Object> get props => [value];
}

class IsActiveChanged extends SystemUserFormEvent {
  final bool value;
  const IsActiveChanged(this.value);
  @override
  List<Object> get props => [value];
}

class IsSuperAdminChanged extends SystemUserFormEvent {
  final bool value;
  const IsSuperAdminChanged(this.value);
  @override
  List<Object> get props => [value];
}

class ButtonSubmitted extends SystemUserFormEvent {}
