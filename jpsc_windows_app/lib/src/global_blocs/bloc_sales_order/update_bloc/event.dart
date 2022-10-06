part of 'bloc.dart';

abstract class SalesOrderUpdateEvent extends Equatable {
  const SalesOrderUpdateEvent();
  @override
  List<Object?> get props => [];
}

class DispatchBranchChanged extends SalesOrderUpdateEvent {
  final String dispatchingBranch;
  const DispatchBranchChanged(this.dispatchingBranch);
  @override
  List<Object?> get props => [dispatchingBranch];
}

class OrderStatusChanged extends SalesOrderUpdateEvent {
  final int orderStatus;
  const OrderStatusChanged(this.orderStatus);
  @override
  List<Object?> get props => [orderStatus];
}

class SalesOrderRemarksChanged extends SalesOrderUpdateEvent {
  final String remarks;
  const SalesOrderRemarksChanged(this.remarks);
  @override
  List<Object> get props => [remarks];
}

class SalesOrderRowsChanged extends SalesOrderUpdateEvent {
  final List<SalesOrderRowModel> salesOrderRows;
  const SalesOrderRowsChanged(this.salesOrderRows);
  @override
  List<Object?> get props => [salesOrderRows];
}

class SalesOrderUpdateSubmitted extends SalesOrderUpdateEvent {}
