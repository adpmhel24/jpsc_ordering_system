import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';

import '../../../data/models/models.dart';
import '../../../data/models/sales_order/row_model.dart';
import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class SalesOrderUpdateBloc
    extends Bloc<SalesOrderUpdateEvent, SalesOrderUpdateState> {
  final SalesOrderModel selectedSalesOrder;
  final SalesOrderRepo salesOrdeRepo;
  SalesOrderUpdateBloc(
      {required this.selectedSalesOrder, required this.salesOrdeRepo})
      : super(SalesOrderUpdateState(salesOrder: selectedSalesOrder)) {
    on<DispatchBranchChanged>(_onDispatchBranchChanged);
    on<OrderStatusChanged>(_onOrderStatusChanged);
    on<SalesOrderRemarksChanged>(_onSalesOrderRemarksChanged);
    on<SalesOrderRowsChanged>(_onSalesOrderRowsChanged);
    on<SalesOrderUpdateSubmitted>(_onSalesOrderUpdateSubmitted);
  }

  void _onDispatchBranchChanged(
      DispatchBranchChanged event, Emitter<SalesOrderUpdateState> emit) {
    SalesOrderModel salesOrder =
        SalesOrderModel.fromJson(state.salesOrder.toJson());
    salesOrder.dispatchingBranch = event.dispatchingBranch;
    emit(state.copyWith(salesOrder: salesOrder));
  }

  void _onOrderStatusChanged(
      OrderStatusChanged event, Emitter<SalesOrderUpdateState> emit) {
    SalesOrderModel salesOrder =
        SalesOrderModel.fromJson(state.salesOrder.toJson());
    salesOrder.orderStatus = event.orderStatus;
    emit(state.copyWith(salesOrder: salesOrder));
  }

  void _onSalesOrderRemarksChanged(
      SalesOrderRemarksChanged event, Emitter<SalesOrderUpdateState> emit) {
    SalesOrderModel salesOrder =
        SalesOrderModel.fromJson(state.salesOrder.toJson());
    salesOrder.remarks = event.remarks;
    emit(state.copyWith(salesOrder: salesOrder));
  }

  void _onSalesOrderRowsChanged(
      SalesOrderRowsChanged event, Emitter<SalesOrderUpdateState> emit) {
    SalesOrderModel salesOrder =
        SalesOrderModel.fromJson(state.salesOrder.toJson());
    salesOrder.rows = event.salesOrderRows;
    double subtotal = 0;
    double gross = 0;

    for (var e in event.salesOrderRows) {
      subtotal += e.linetotal;
      gross += subtotal;
    }
    salesOrder.subtotal = subtotal;
    salesOrder.gross = gross;

    emit(state.copyWith(salesOrder: salesOrder));
  }

  void _onSalesOrderUpdateSubmitted(SalesOrderUpdateSubmitted event,
      Emitter<SalesOrderUpdateState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      String message =
          await salesOrdeRepo.update(data: state.salesOrder.toJson());
      emit(state.copyWith(status: FetchingStatus.success, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
