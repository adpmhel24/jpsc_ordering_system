part of 'bloc.dart';

abstract class ItemRowBlocEvent extends Equatable {
  const ItemRowBlocEvent();
  @override
  List<Object?> get props => [];
}

class ItemCodeChanged extends ItemRowBlocEvent {
  final String itemCode;
  const ItemCodeChanged(this.itemCode);
  @override
  List<Object?> get props => [itemCode];
}

class QuantityChanged extends ItemRowBlocEvent {
  final double? quantity;
  const QuantityChanged(this.quantity);
  @override
  List<Object?> get props => [quantity];
}

class UomChanged extends ItemRowBlocEvent {
  final String uom;
  const UomChanged(this.uom);
  @override
  List<Object?> get props => [uom];
}

class WarehouseChanged extends ItemRowBlocEvent {
  final String warehouse;
  const WarehouseChanged(this.warehouse);
  @override
  List<Object?> get props => [warehouse];
}
