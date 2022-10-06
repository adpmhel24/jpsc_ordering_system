import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingSalesOrderHeaderBloc
    extends Bloc<FetchingSalesOrderHeaderEvent, FetchingSalesOrderHeaderState> {
  final SalesOrderRepo _salesOrderRepo;
  FetchingSalesOrderHeaderBloc(this._salesOrderRepo)
      : super(const FetchingSalesOrderHeaderState()) {
    on<FetchAllSalesOrderHeader>(_onFetchAllSalesOrderHeader);
  }

  void _onFetchAllSalesOrderHeader(FetchAllSalesOrderHeader event,
      Emitter<FetchingSalesOrderHeaderState> emit) async {
    final Map<String, dynamic> params = {
      "branch": event.branch,
      "from_date": event.fromDate,
      "to_date": event.toDate,
      if (event.orderStatus != null) "order_status": event.orderStatus,
      "docstatus": event.docStatus,
    };
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await _salesOrderRepo.getAll(params: params);
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          datas: _salesOrderRepo.datas,
          forPriceConfirmation: _salesOrderRepo.forPriceConf,
          forCreditConfirmation: _salesOrderRepo.forCreditConf,
          forDispatch: _salesOrderRepo.forDispatch,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
