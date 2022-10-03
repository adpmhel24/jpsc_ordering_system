part of 'bloc.dart';

class PricelistRowsUpdateState extends Equatable {
  final FormzStatus status;
  final String message;

  const PricelistRowsUpdateState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  PricelistRowsUpdateState copyWith({
    FormzStatus? status,
    String? message,
  }) {
    return PricelistRowsUpdateState(
        message: message ?? this.message, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, message];
}
