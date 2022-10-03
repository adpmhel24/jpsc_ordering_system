part of 'bloc.dart';

class ItemRowBlocState extends Equatable {
  final FormzStatus status;
  final FormzString itemCode;
  final FormzDouble quantity;
  final FormzString uom;
  final FormzString warehouse;

  const ItemRowBlocState({
    this.status = FormzStatus.pure,
    this.itemCode = const FormzString.pure(),
    this.quantity = const FormzDouble.pure(),
    this.uom = const FormzString.pure(),
    this.warehouse = const FormzString.pure(),
  });

  ItemRowBlocState copyWith({
    FormzStatus? status,
    FormzString? itemCode,
    FormzDouble? quantity,
    FormzString? uom,
    FormzString? warehouse,
  }) {
    return ItemRowBlocState(
      status: status ?? this.status,
      itemCode: itemCode ?? this.itemCode,
      quantity: quantity ?? this.quantity,
      uom: uom ?? this.uom,
      warehouse: warehouse ?? this.warehouse,
    );
  }

  @override
  List<Object?> get props => [status, itemCode, quantity, uom, warehouse];
}
