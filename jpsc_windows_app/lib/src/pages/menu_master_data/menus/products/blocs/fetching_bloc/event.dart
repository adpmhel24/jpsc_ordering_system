part of 'bloc.dart';

abstract class FetchingProductsEvent extends Equatable {
  const FetchingProductsEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductsOnline extends FetchingProductsEvent {}

class LoadProductsOffline extends FetchingProductsEvent {}

class OfflineProductSearchByKeyword extends FetchingProductsEvent {
  final String value;
  const OfflineProductSearchByKeyword(this.value);
  @override
  List<Object?> get props => [value];
}
