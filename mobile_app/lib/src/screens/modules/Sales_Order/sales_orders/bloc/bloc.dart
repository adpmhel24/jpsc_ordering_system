import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../utils/fetching_status.dart';

part 'events.dart';
part 'states.dart';

enum OrderStatusEnum { forPriceConfirmation, forCreditConfirmation, dispatched }

class SalesOrdersBloc extends Bloc<SalesOrdersEvent, SalesOrdersState> {
  final SalesOrderRepo _orderRepo;
  SalesOrdersBloc(this._orderRepo) : super(const SalesOrdersState()) {
    on<FetchSalesOrder>(_onFetchSalesOrder);
  }

  void _onFetchSalesOrder(
      FetchSalesOrder event, Emitter<SalesOrdersState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    final Map<String, dynamic> params = {
      if (event.orderStatus != null) "order_status": event.orderStatus,
      "from_date": event.fromDate,
      "to_date": event.toDate,
      "docstatus": event.docStatus,
    };
    try {
      await _orderRepo.getAllOrdersByOwner(params: params);
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          datas: _orderRepo.datas,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          message: e.message,
        ),
      );
    }
  }
}
