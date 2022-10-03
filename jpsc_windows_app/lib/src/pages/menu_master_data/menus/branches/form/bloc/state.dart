part of 'bloc.dart';

class BranchFormState extends Equatable {
  final FormzStatus status;
  final FormzString code;
  final FormzString description;
  final FormzString pricelistCode;
  final FormzBool isActive;
  final String message;

  const BranchFormState({
    this.status = FormzStatus.pure,
    this.code = const FormzString.pure(),
    this.description = const FormzString.pure(),
    this.pricelistCode = const FormzString.pure(),
    this.isActive = const FormzBool.pure(),
    this.message = "",
  });

  BranchFormState copyWith({
    FormzStatus? status,
    FormzString? code,
    FormzString? description,
    FormzString? pricelistCode,
    FormzBool? isActive,
    String? message,
  }) {
    return BranchFormState(
      status: status ?? this.status,
      code: code ?? this.code,
      description: description ?? this.description,
      pricelistCode: pricelistCode ?? this.pricelistCode,
      isActive: isActive ?? this.isActive,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        code,
        description,
        isActive,
        pricelistCode,
        message,
      ];
}
