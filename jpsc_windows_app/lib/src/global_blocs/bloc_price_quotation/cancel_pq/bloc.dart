import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';

import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class PriceQuotationCancelBloc
    extends Bloc<PriceQuotationCancelEvent, PriceQuotationCancelState> {
  final PriceQuotationRepo priceQuotationRepo;
  PriceQuotationCancelBloc(this.priceQuotationRepo)
      : super(const PriceQuotationCancelState()) {
    on<PriceQuotationCancelSubmitted>(_onPriceQuotationCancelSubmitted);
  }

  void _onPriceQuotationCancelSubmitted(PriceQuotationCancelSubmitted event,
      Emitter<PriceQuotationCancelState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      String message = await priceQuotationRepo
          .cancel(fk: event.fk, data: {"comment": event.remarks});
      emit(state.copyWith(status: FetchingStatus.success, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
