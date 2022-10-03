part of 'bloc.dart';

abstract class SalesOrderCancelEvent extends Equatable {
  const SalesOrderCancelEvent();
  @override
  List<Object?> get props => [];
}

class SalesOrderCancelSubmitted extends SalesOrderCancelEvent {
  final int fk;
  final String remarks;

  const SalesOrderCancelSubmitted(this.fk, this.remarks);

  @override
  List<Object?> get props => [fk, remarks];
}
