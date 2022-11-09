part of 'bloc.dart';

abstract class PricelistFetchingEvent extends Equatable {
  const PricelistFetchingEvent();
  @override
  List<Object?> get props => [];
}

class LoadPricelist extends PricelistFetchingEvent {}

class SearchPricelistByKeyword extends PricelistFetchingEvent {
  final String keyword;
  const SearchPricelistByKeyword(this.keyword);
  @override
  List<Object?> get props => [keyword];
}
