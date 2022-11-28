part of 'bloc.dart';

class FetchingPQDetailsState extends Equatable {
  final FetchingStatus status;
  final PriceQuotationModel? data;
  final String message;

  const FetchingPQDetailsState(
      {this.status = FetchingStatus.init, this.data, this.message = ""});

  FetchingPQDetailsState copyWith({
    FetchingStatus? status,
    PriceQuotationModel? data,
    String? message,
  }) =>
      FetchingPQDetailsState(
          status: status ?? this.status,
          data: data ?? this.data,
          message: message ?? this.message);

  @override
  List<Object?> get props => [status, data, message];
}
