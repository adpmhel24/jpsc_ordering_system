part of 'bloc.dart';

class ProductBulkInsertState extends Equatable {
  final FormzStatus status;
  final String message;

  const ProductBulkInsertState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  ProductBulkInsertState copyWith({
    FormzStatus? status,
    String? message,
  }) =>
      ProductBulkInsertState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
