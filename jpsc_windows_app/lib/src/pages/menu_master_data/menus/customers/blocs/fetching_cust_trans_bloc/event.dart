part of 'bloc.dart';

abstract class FetchingCustTransactionsEvent extends Equatable {
  const FetchingCustTransactionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomerTransactions extends FetchingCustTransactionsEvent {
  final String customerCode;
  final int? page;
  final int? size;
  final String? fromDate;
  final String? toDate;

  const LoadCustomerTransactions({
    required this.customerCode,
    this.fromDate,
    this.toDate,
    this.page,
    this.size,
  });
  @override
  List<Object?> get props => [customerCode, page, size, fromDate, toDate];
}
