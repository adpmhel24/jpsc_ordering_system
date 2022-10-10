part of 'bloc.dart';

abstract class FetchingPriceQuotationHeaderEvent extends Equatable {
  const FetchingPriceQuotationHeaderEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllPriceQuotationHeader extends FetchingPriceQuotationHeaderEvent {
  final String fromDate;
  final String toDate;
  final int? pqStatus;
  final String docStatus;

  const FetchAllPriceQuotationHeader({
    required this.docStatus,
    required this.pqStatus,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        pqStatus,
        docStatus,
      ];
}
