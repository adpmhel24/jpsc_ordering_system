part of 'bloc.dart';

class FetchingSalesOrderHeaderState extends Equatable {
  final FetchingStatus status;
  final List<SalesOrderModel> datas;
  final int forPriceConfirmation;
  final int forCreditConfirmation;
  final int forDispatch;
  final String message;

  const FetchingSalesOrderHeaderState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.forPriceConfirmation = 0,
    this.forCreditConfirmation = 0,
    this.forDispatch = 0,
    this.message = "",
  });

  FetchingSalesOrderHeaderState copyWith({
    FetchingStatus? status,
    List<SalesOrderModel>? datas,
    int? forPriceConfirmation,
    int? forCreditConfirmation,
    int? forDispatch,
    String? message,
  }) {
    return FetchingSalesOrderHeaderState(
      status: status ?? this.status,
      datas: datas ?? this.datas,
      forPriceConfirmation: forPriceConfirmation ?? this.forPriceConfirmation,
      forCreditConfirmation:
          forCreditConfirmation ?? this.forCreditConfirmation,
      forDispatch: forDispatch ?? this.forDispatch,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        datas,
        forPriceConfirmation,
        forCreditConfirmation,
        forDispatch,
        message,
      ];
}
