part of 'bloc.dart';

abstract class FetchingPriceListRowEvent extends Equatable {
  const FetchingPriceListRowEvent();
  @override
  List<Object?> get props => [];
}

class LoadPricelistRowByPricelistCode extends FetchingPriceListRowEvent {
  final String value;
  const LoadPricelistRowByPricelistCode(this.value);

  @override
  List<Object?> get props => [value];
}

class LoadPricelistRowByItemCode extends FetchingPriceListRowEvent {
  final String value;
  const LoadPricelistRowByItemCode(this.value);

  @override
  List<Object?> get props => [value];
}
