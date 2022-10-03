part of 'bloc.dart';

abstract class FetchingSalesOrderHeaderEvent extends Equatable {
  const FetchingSalesOrderHeaderEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllSalesOrderHeader extends FetchingSalesOrderHeaderEvent {
  final String fromDate;
  final String toDate;
  final int? orderStatus;
  final String docStatus;

  const FetchAllSalesOrderHeader(
      {required this.docStatus,
      required this.orderStatus,
      required this.fromDate,
      required this.toDate});

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        orderStatus,
        docStatus,
      ];
}
