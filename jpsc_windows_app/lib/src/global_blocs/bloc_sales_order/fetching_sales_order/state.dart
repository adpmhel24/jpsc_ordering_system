part of 'bloc.dart';

class FetchingSalesOrderHeaderState extends Equatable {
  final FetchingStatus status;
  final List<SalesOrderModel> datas;
  final String message;

  const FetchingSalesOrderHeaderState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  FetchingSalesOrderHeaderState copyWith({
    FetchingStatus? status,
    List<SalesOrderModel>? datas,
    String? message,
  }) {
    return FetchingSalesOrderHeaderState(
      status: status ?? this.status,
      datas: datas ?? this.datas,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, datas, message];
}
