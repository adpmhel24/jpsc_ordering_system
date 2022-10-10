part of 'bloc.dart';

class FetchingPriceQuotationHeaderState extends Equatable {
  final FetchingStatus status;
  final List<PriceQuotationModel> datas;
  final int forPriceConfirmation;
  final int forCreditConfirmation;
  final int forDispatch;
  final String message;

  const FetchingPriceQuotationHeaderState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.forPriceConfirmation = 0,
    this.forCreditConfirmation = 0,
    this.forDispatch = 0,
    this.message = "",
  });

  FetchingPriceQuotationHeaderState copyWith({
    FetchingStatus? status,
    List<PriceQuotationModel>? datas,
    int? forPriceConfirmation,
    int? forCreditConfirmation,
    int? forDispatch,
    String? message,
  }) {
    return FetchingPriceQuotationHeaderState(
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
