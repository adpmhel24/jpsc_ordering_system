part of 'bloc.dart';

class SalesOrdersState extends Equatable {
  final FetchingStatus status;
  final List<SalesOrderModel> datas;
  final String message;

  const SalesOrdersState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  SalesOrdersState copyWith({
    FetchingStatus? status,
    List<SalesOrderModel>? datas,
    String? message,
  }) =>
      SalesOrdersState(
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
