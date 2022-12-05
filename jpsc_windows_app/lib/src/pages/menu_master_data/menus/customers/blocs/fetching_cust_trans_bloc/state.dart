part of 'bloc.dart';

class FetchingCustTransactionsState extends Equatable {
  final FetchingStatus status;
  final List<PriceQuotationModel> datas;
  final int total;
  final int startIndex;
  final int endIndex;
  final int rowsPerPage;
  final String message;
  final Map<String, dynamic> links;

  const FetchingCustTransactionsState({
    this.status = FetchingStatus.init,
    this.total = 0,
    this.startIndex = 0,
    this.endIndex = 0,
    this.rowsPerPage = 0,
    this.links = const {},
    this.datas = const [],
    this.message = "",
  });

  FetchingCustTransactionsState copyWith({
    FetchingStatus? status,
    List<PriceQuotationModel>? datas,
    int? total,
    int? startIndex,
    int? endIndex,
    int? rowsPerPage,
    Map<String, dynamic>? links,
    String? message,
  }) =>
      FetchingCustTransactionsState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        total: total ?? this.total,
        startIndex: startIndex ?? this.startIndex,
        endIndex: endIndex ?? this.endIndex,
        rowsPerPage: rowsPerPage ?? this.rowsPerPage,
        links: links ?? this.links,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        datas,
        total,
        startIndex,
        endIndex,
        rowsPerPage,
        message,
      ];
}
