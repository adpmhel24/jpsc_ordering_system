part of 'bloc.dart';

class CreateUpdatePaymentTermState extends Equatable {
  final FormzStatus status;
  final FormzString code;
  final FormzString description;
  final String message;

  const CreateUpdatePaymentTermState({
    this.status = FormzStatus.pure,
    this.code = const FormzString.pure(),
    this.description = const FormzString.pure(),
    this.message = "",
  });

  CreateUpdatePaymentTermState copyWith({
    FormzStatus? status,
    FormzString? code,
    FormzString? description,
    String? message,
  }) =>
      CreateUpdatePaymentTermState(
        status: status ?? this.status,
        code: code ?? this.code,
        description: description ?? this.description,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        code,
        description,
        message,
      ];
}
