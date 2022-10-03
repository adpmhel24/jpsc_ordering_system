part of 'bloc.dart';

abstract class ItemGroupsBlocEvent extends Equatable {
  const ItemGroupsBlocEvent();

  @override
  List<Object?> get props => [];
}

class LoadItemGroups extends ItemGroupsBlocEvent {}
