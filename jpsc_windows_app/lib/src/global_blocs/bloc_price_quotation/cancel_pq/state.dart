part of 'bloc.dart';

class PriceQuotationCancelState extends Equatable {
  final FetchingStatus status;
  final String message;

  const PriceQuotationCancelState({
    this.status = FetchingStatus.init,
    this.message = "",
  });

  PriceQuotationCancelState copyWith({
    FetchingStatus? status,
    String? message,
  }) =>
      PriceQuotationCancelState(
          status: status ?? this.status, message: message ?? this.message);
  @override
  List<Object?> get props => [status, message];
}
