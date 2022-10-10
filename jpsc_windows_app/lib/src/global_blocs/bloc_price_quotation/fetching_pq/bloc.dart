import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPriceQuotationHeaderBloc extends Bloc<
    FetchingPriceQuotationHeaderEvent, FetchingPriceQuotationHeaderState> {
  final PriceQuotationRepo _priceQuotationRepo;
  FetchingPriceQuotationHeaderBloc(this._priceQuotationRepo)
      : super(const FetchingPriceQuotationHeaderState()) {
    on<FetchAllPriceQuotationHeader>(_onFetchAllPriceQuotationHeader);
  }

  void _onFetchAllPriceQuotationHeader(FetchAllPriceQuotationHeader event,
      Emitter<FetchingPriceQuotationHeaderState> emit) async {
    final Map<String, dynamic> params = {
      "from_date": event.fromDate,
      "to_date": event.toDate,
      if (event.pqStatus != null) "pq_status": event.pqStatus,
      "docstatus": event.docStatus,
    };
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await _priceQuotationRepo.getAll(params: params);
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          datas: _priceQuotationRepo.datas,
          forPriceConfirmation: _priceQuotationRepo.forPriceConf,
          forCreditConfirmation: _priceQuotationRepo.forCreditConf,
          forDispatch: _priceQuotationRepo.forDispatch,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
