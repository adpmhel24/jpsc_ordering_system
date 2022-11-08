part of 'bloc.dart';

abstract class FetchingItemGroupEvent extends Equatable {
  const FetchingItemGroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemGroups extends FetchingItemGroupEvent {}
