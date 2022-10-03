import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';

import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class SalesOrderCancelBloc
    extends Bloc<SalesOrderCancelEvent, SalesOrderCancelState> {
  final SalesOrderRepo salesOrderRepo;
  SalesOrderCancelBloc(this.salesOrderRepo)
      : super(const SalesOrderCancelState()) {
    on<SalesOrderCancelSubmitted>(_onSalesOrderCancelSubmitted);
  }

  void _onSalesOrderCancelSubmitted(SalesOrderCancelSubmitted event,
      Emitter<SalesOrderCancelState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      String message = await salesOrderRepo
          .cancel(fk: event.fk, data: {"comment": event.remarks});
      emit(state.copyWith(status: FetchingStatus.success, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
