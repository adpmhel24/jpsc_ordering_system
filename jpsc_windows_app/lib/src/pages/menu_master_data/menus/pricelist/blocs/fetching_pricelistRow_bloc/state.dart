part of 'bloc.dart';

class FetchingPriceListRowState extends Equatable {
  final FetchingStatus status;
  final List<PricelistRowModel> datas;
  final String message;

  const FetchingPriceListRowState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  FetchingPriceListRowState copyWith({
    FetchingStatus? status,
    List<PricelistRowModel>? datas,
    String? message,
  }) =>
      FetchingPriceListRowState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, datas, message];
}
