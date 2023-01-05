import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../utils/fetching_status.dart';

part 'events.dart';
part 'states.dart';

enum OrderStatusEnum { forPriceConfirmation, forCreditConfirmation, dispatched }

class PriceQuotationsBloc extends Bloc<SalesOrdersEvent, PriceQuotationsState> {
  final PriceQuotationRepo _orderRepo;
  PriceQuotationsBloc(this._orderRepo) : super(const PriceQuotationsState()) {
    on<FetchPriceQuotation>(_onFetchPriceQuotation);
  }

  void _onFetchPriceQuotation(
      FetchPriceQuotation event, Emitter<PriceQuotationsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    final Map<String, dynamic> params = {
      if (event.pqStatus != null) "pq_status": event.pqStatus,
      "from_date": event.fromDate,
      "to_date": event.toDate,
      "docstatus": event.docStatus,
    };
    try {
      await _orderRepo.getAllMyTransaction(params: params);
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
    } catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
