part of 'bloc.dart';

class SalesOrderUpdateState extends Equatable {
  final FetchingStatus status;
  final SalesOrderModel salesOrder;
  final String message;

  const SalesOrderUpdateState({
    this.status = FetchingStatus.init,
    required this.salesOrder,
    this.message = "",
  });

  SalesOrderUpdateState copyWith({
    FetchingStatus? status,
    SalesOrderModel? salesOrder,
    String? message,
  }) =>
      SalesOrderUpdateState(
        status: status ?? this.status,
        salesOrder: salesOrder ?? this.salesOrder,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        salesOrder,
        message,
      ];
}
