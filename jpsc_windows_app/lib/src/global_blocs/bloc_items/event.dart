part of 'bloc.dart';

abstract class ItemsBlocEvent extends Equatable {
  const ItemsBlocEvent();
  @override
  List<Object?> get props => [];
}

class LoadItems extends ItemsBlocEvent {}
