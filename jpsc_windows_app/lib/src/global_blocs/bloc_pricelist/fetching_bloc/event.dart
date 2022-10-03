part of 'bloc.dart';

abstract class PricelistFetchingEvent extends Equatable {
  const PricelistFetchingEvent();
  @override
  List<Object?> get props => [];
}

class FetchAllPricelist extends PricelistFetchingEvent {}

class FilterPricelist extends PricelistFetchingEvent {
  final String keyword;
  const FilterPricelist(this.keyword);
  @override
  List<Object?> get props => [keyword];
}
