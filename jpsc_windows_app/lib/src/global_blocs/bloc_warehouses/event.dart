part of 'bloc.dart';

abstract class WarehousesBlocEvent extends Equatable {
  const WarehousesBlocEvent();
  @override
  List<Object?> get props => [];
}

class LoadWarehouses extends WarehousesBlocEvent {}
