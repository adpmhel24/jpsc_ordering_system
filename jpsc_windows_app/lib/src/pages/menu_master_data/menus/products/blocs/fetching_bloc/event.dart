part of 'bloc.dart';

abstract class FetchingProductsEvent extends Equatable {
  const FetchingProductsEvent();
  @override
  List<Object?> get props => [];
}

class LoadProducts extends FetchingProductsEvent {}
