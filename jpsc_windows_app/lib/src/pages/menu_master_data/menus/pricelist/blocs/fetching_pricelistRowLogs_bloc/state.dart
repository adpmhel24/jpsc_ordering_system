part of 'bloc.dart';

class FetchingPricelistRowLogsState extends Equatable {
  final FetchingStatus status;
  final List<PricelistRowLogModel> datas;
  final String message;

  const FetchingPricelistRowLogsState(
      {this.status = FetchingStatus.init,
      this.datas = const [],
      this.message = ""});

  FetchingPricelistRowLogsState copyWith({
    FetchingStatus? status,
    List<PricelistRowLogModel>? datas,
    String? message,
  }) =>
      FetchingPricelistRowLogsState(
          status: status ?? this.status,
          datas: datas ?? this.datas,
          message: message ?? this.message);

  @override
  List<Object?> get props => [status, datas, message];
}
