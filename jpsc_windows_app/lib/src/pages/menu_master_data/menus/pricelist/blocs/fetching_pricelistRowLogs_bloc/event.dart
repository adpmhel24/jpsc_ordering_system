part of 'bloc.dart';

abstract class FetchingPricelistRowLogsEvent extends Equatable {
  const FetchingPricelistRowLogsEvent();
  @override
  List<Object?> get props => [];
}

class LoadPricelistRowLogs extends FetchingPricelistRowLogsEvent {
  final int pricelistRowId;
  const LoadPricelistRowLogs(this.pricelistRowId);
  @override
  List<Object?> get props => [pricelistRowId];
}
