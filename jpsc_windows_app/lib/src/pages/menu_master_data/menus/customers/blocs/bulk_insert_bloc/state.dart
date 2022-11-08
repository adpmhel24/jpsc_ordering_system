part of 'bloc.dart';

class CustomerBulkInsertState extends Equatable {
  final FormzStatus status;
  final String message;

  const CustomerBulkInsertState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  CustomerBulkInsertState copyWith({
    FormzStatus? status,
    String? message,
  }) =>
      CustomerBulkInsertState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
