part of 'itemform_bloc.dart';

class ItemFormState extends Equatable {
  final FormzStatus status;
  final FormzString code;
  final FormzString formzDescription;
  final FormzString formzItemGroup;

  final FormzString formzSaleUom;

  final FormzBool formzIsActive;
  final String message;
  const ItemFormState({
    this.status = FormzStatus.pure,
    this.code = const FormzString.pure(),
    this.formzDescription = const FormzString.pure(),
    this.formzItemGroup = const FormzString.pure(),
    this.formzSaleUom = const FormzString.pure(),
    this.formzIsActive = const FormzBool.pure(),
    this.message = "",
  });

  ItemFormState copyWith({
    FormzStatus? status,
    FormzString? code,
    FormzString? formzDescription,
    FormzString? formzItemGroup,
    FormzString? formzSaleUom,
    FormzBool? formzIsActive,
    String? message,
  }) {
    return ItemFormState(
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
