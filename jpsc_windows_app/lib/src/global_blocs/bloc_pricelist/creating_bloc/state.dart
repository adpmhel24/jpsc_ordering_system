part of 'bloc.dart';

class PricelistCreateState extends Equatable {
  final FormzStatus status;
  final FormzString code;
  final FormzString description;
  final FormzBool isActive;
  final String message;

  const PricelistCreateState({
    this.status = FormzStatus.pure,
    this.code = const FormzString.pure(),
    this.description = const FormzString.pure(),
    this.isActive = const FormzBool.pure(),
    this.message = "",
  });

  PricelistCreateState copyWith({
    FormzStatus? status,
    FormzString? code,
    FormzString? description,
    FormzBool? isActive,
    String? message,
  }) {
    return PricelistCreateState(
      status: status ?? this.status,
      code: code ?? this.code,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        code,
        isActive,
        description,
        message,
      ];
}
