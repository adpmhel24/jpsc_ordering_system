part of 'bloc.dart';

class PriceQuotationUpdateState extends Equatable {
  final FetchingStatus status;
  final PriceQuotationModel priceQuotation;
  final String message;

  const PriceQuotationUpdateState({
    this.status = FetchingStatus.init,
    required this.priceQuotation,
    this.message = "",
  });

  PriceQuotationUpdateState copyWith({
    FetchingStatus? status,
    PriceQuotationModel? priceQuotation,
    String? message,
  }) =>
      PriceQuotationUpdateState(
        status: status ?? this.status,
        priceQuotation: priceQuotation ?? this.priceQuotation,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        priceQuotation,
        message,
      ];
}
