import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../utils/formz_double.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class ItemRowBloc extends Bloc<ItemRowBlocEvent, ItemRowBlocState> {
  ItemRowBloc() : super(const ItemRowBlocState()) {
    on<ItemCodeChanged>(_onItemCodeChanged);
    on<QuantityChanged>(_onQuantityChanged);
    on<UomChanged>(_onUomChanged);
    on<WarehouseChanged>(_onWarehouseChanged);
  }

  void _onItemCodeChanged(
      ItemCodeChanged event, Emitter<ItemRowBlocState> emit) {
    final FormzString itemCode = FormzString.dirty(event.itemCode);
    emit(
      state.copyWith(
        itemCode: itemCode,
        status: Formz.validate([
          itemCode,
          state.quantity,
          state.uom,
          state.warehouse,
        ]),
      ),
    );
  }

  void _onQuantityChanged(
      QuantityChanged event, Emitter<ItemRowBlocState> emit) {
    final FormzDouble quantity = FormzDouble.dirty(event.quantity);

    emit(
      state.copyWith(
        quantity: quantity,
        status: Formz.validate([
          quantity,
          state.itemCode,
          state.warehouse,
          state.uom,
        ]),
      ),
    );
  }

  void _onUomChanged(UomChanged event, Emitter<ItemRowBlocState> emit) {
    final FormzString uom = FormzString.dirty(event.uom);

    emit(
      state.copyWith(
        uom: uom,
        status: Formz.validate([
          uom,
          state.itemCode,
          state.warehouse,
          state.quantity,
        ]),
      ),
    );
  }

  void _onWarehouseChanged(
      WarehouseChanged event, Emitter<ItemRowBlocState> emit) {
    final FormzString warehouse = FormzString.dirty(event.warehouse);

    emit(
      state.copyWith(
        warehouse: warehouse,
        status: Formz.validate([
          warehouse,
          state.itemCode,
          state.uom,
          state.quantity,
        ]),
      ),
    );
  }
}
