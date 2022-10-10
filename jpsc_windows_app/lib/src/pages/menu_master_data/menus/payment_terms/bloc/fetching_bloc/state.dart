part of 'bloc.dart';

class FetchingPaymentTermsState extends Equatable {
  final FetchingStatus status;
  final List<PaymentTermModel> datas;
  final String message;

  const FetchingPaymentTermsState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  FetchingPaymentTermsState copyWith({
    FetchingStatus? status,
    List<PaymentTermModel>? datas,
    String? message,
  }) =>
      FetchingPaymentTermsState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, datas, message];
}
