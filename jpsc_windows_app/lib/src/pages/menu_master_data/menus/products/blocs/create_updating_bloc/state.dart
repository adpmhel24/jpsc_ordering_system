part of 'bloc.dart';

class CreateUpdateProductState extends Equatable {
  final FormzStatus status;
  final FormzString code;
  final FormzString formzDescription;
  final FormzString formzItemGroup;

  final FormzString formzSaleUom;

  final FormzBool formzIsActive;
  final String message;
  const CreateUpdateProductState({
    this.status = FormzStatus.pure,
    this.code = const FormzString.pure(),
    this.formzDescription = const FormzString.pure(),
    this.formzItemGroup = const FormzString.pure(),
    this.formzSaleUom = const FormzString.pure(),
    this.formzIsActive = const FormzBool.pure(),
    this.message = "",
  });

  CreateUpdateProductState copyWith({
    FormzStatus? status,
    FormzString? code,
    FormzString? formzDescription,
    FormzString? formzItemGroup,
    FormzString? formzSaleUom,
    FormzBool? formzIsActive,
    String? message,
  }) {
    return CreateUpdateProductState(
      status: status ?? this.status,
      code: code ?? this.code,
      formzDescription: formzDescription ?? this.formzDescription,
      formzItemGroup: formzItemGroup ?? this.formzItemGroup,
      formzSaleUom: formzSaleUom ?? this.formzSaleUom,
      formzIsActive: formzIsActive ?? this.formzIsActive,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        code,
        formzDescription,
        formzItemGroup,
        formzSaleUom,
        formzIsActive,
        message,
      ];
}
