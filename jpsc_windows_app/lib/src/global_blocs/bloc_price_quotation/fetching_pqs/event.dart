part of 'bloc.dart';

abstract class FetchingPriceQuotationHeaderEvent extends Equatable {
  const FetchingPriceQuotationHeaderEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllPriceQuotationHeader extends FetchingPriceQuotationHeaderEvent {
  final String branch;
  final String fromDate;
  final String toDate;
  final int? pqStatus;
  final String docStatus;

  const FetchAllPriceQuotationHeader({
    required this.branch,
    required this.docStatus,
    required this.pqStatus,
    required this.fromDate,
    required this.toDate,
  });

  @override
  List<Object?> get props => [
        branch,
        fromDate,
        toDate,
        pqStatus,
        docStatus,
      ];
}
