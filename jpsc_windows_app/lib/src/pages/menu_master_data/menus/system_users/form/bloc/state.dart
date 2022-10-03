part of 'bloc.dart';

class SystemUserFormState extends Equatable {
  final FormzStatus status;
  final FormzString firstName;
  final FormzString lastName;
  final FormzEmail email;
  final FormzString password;
  final FormzBool isActive;
  final FormzString positionCode;
  final String message;

  const SystemUserFormState({
    this.status = FormzStatus.pure,
    this.firstName = const FormzString.pure(),
    this.lastName = const FormzString.pure(),
    this.email = const FormzEmail.pure(),
    this.password = const FormzString.pure(),
    this.positionCode = const FormzString.pure(),
    this.isActive = const FormzBool.dirty(true),
    this.message = "",
  });

  SystemUserFormState copyWith({
    FormzStatus? status,
    FormzString? firstName,
    FormzString? lastName,
    FormzEmail? email,
    FormzString? password,
    FormzString? positionCode,
    String? message,
  }) {
    return SystemUserFormState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      positionCode: positionCode ?? this.positionCode,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstName,
        lastName,
        email,
        password,
        positionCode,
        isActive,
        message,
      ];
}
