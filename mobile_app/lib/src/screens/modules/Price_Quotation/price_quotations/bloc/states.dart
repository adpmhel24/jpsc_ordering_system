part of 'bloc.dart';

class PriceQuotationsState extends Equatable {
  final FetchingStatus status;
  final List<PriceQuotationModel> datas;
  final String message;

  const PriceQuotationsState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  PriceQuotationsState copyWith({
    FetchingStatus? status,
    List<PriceQuotationModel>? datas,
    String? message,
  }) =>
      PriceQuotationsState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        datas,
        message,
      ];
}
