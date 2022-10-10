part of 'bloc.dart';

abstract class PriceQuotationCancelEvent extends Equatable {
  const PriceQuotationCancelEvent();
  @override
  List<Object?> get props => [];
}

class PriceQuotationCancelSubmitted extends PriceQuotationCancelEvent {
  final int fk;
  final String remarks;

  const PriceQuotationCancelSubmitted(this.fk, this.remarks);

  @override
  List<Object?> get props => [fk, remarks];
}
