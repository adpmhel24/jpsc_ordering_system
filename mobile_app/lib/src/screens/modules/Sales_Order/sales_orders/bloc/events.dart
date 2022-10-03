part of 'bloc.dart';

abstract class SalesOrdersEvent extends Equatable {
  const SalesOrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchSalesOrder extends SalesOrdersEvent {
  final String fromDate;
  final String toDate;
  final int? orderStatus;
  final String docStatus;

  const FetchSalesOrder({
    required this.fromDate,
    required this.toDate,
    this.orderStatus,
    required this.docStatus,
  });
  @override
  List<Object?> get props => [fromDate, toDate, orderStatus, docStatus];
}
