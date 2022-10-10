part of 'bloc.dart';

abstract class SalesOrdersEvent extends Equatable {
  const SalesOrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchPriceQuotation extends SalesOrdersEvent {
  final String fromDate;
  final String toDate;
  final int? pqStatus;
  final String docStatus;

  const FetchPriceQuotation({
    required this.fromDate,
    required this.toDate,
    this.pqStatus,
    required this.docStatus,
  });
  @override
  List<Object?> get props => [fromDate, toDate, pqStatus, docStatus];
}
