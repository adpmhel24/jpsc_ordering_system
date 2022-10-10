part of 'bloc.dart';

abstract class PriceQuotationUpdateEvent extends Equatable {
  const PriceQuotationUpdateEvent();
  @override
  List<Object?> get props => [];
}

class DispatchBranchChanged extends PriceQuotationUpdateEvent {
  final String dispatchingBranch;
  const DispatchBranchChanged(this.dispatchingBranch);
  @override
  List<Object?> get props => [dispatchingBranch];
}

class OrderStatusChanged extends PriceQuotationUpdateEvent {
  final int pqStatus;
  const OrderStatusChanged(this.pqStatus);
  @override
  List<Object?> get props => [pqStatus];
}

class SQNumberChanged extends PriceQuotationUpdateEvent {
  final int? sqNumber;
  const SQNumberChanged(this.sqNumber);
  @override
  List<Object?> get props => [sqNumber];
}

class PriceQuotationRemarksChanged extends PriceQuotationUpdateEvent {
  final String remarks;
  const PriceQuotationRemarksChanged(this.remarks);
  @override
  List<Object> get props => [remarks];
}

class PriceQuotationRowsChanged extends PriceQuotationUpdateEvent {
  final List<PriceQuotationRowModel> priceQuotationRows;
  const PriceQuotationRowsChanged(this.priceQuotationRows);
  @override
  List<Object?> get props => [priceQuotationRows];
}

class PriceQuotationUpdateSubmitted extends PriceQuotationUpdateEvent {}
