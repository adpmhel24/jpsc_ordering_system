part of 'bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProducts extends ProductsEvent {}

class FetchProductWithPriceByLocation extends ProductsEvent {
  final String location;

  const FetchProductWithPriceByLocation(this.location);

  @override
  List<Object?> get props => [location];
}

class SearchProductByKeyword extends ProductsEvent {
  final String keyword;

  const SearchProductByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
