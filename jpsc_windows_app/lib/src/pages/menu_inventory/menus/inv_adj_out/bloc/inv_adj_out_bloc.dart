import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/enums/docstatus.dart';
import '../../../../../utils/fetching_status.dart';

part 'inv_adj_out_event.dart';
part 'inv_adj_out_state.dart';

class InvAdjustmentOutBloc
    extends Bloc<InvAdjustmentOutBlocEvents, InvAdjustmentOutBlocStates> {
  InvAdjustmentOutRepo repo;
  InvAdjustmentOutBloc(this.repo) : super(const InvAdjustmentOutBlocStates()) {
    on<RefreshInvAdjOut>(_onRefreshInvAdjOut);
    on<FilterInvAdjOut>(_onFilterInvAdjOut);
    on<CancelInAdjOut>(_onCancelInAdjOut);
  }

  void _onRefreshInvAdjOut(
      RefreshInvAdjOut event, Emitter<InvAdjustmentOutBlocStates> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await repo.getAll(params: {
        "docstatus": state.docstatus,
        "from_date": state.fromDate,
        "to_date": state.toDate,
      });
      emit(state.copyWith(status: FetchingStatus.success, datas: repo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(status: FetchingStatus.error, message: err.message));
    }
  }

  void _onFilterInvAdjOut(
      FilterInvAdjOut event, Emitter<InvAdjustmentOutBlocStates> emit) async {
    String defaultDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
    String? fromDate = state.fromDate.isEmpty && event.fromDate == null
        ? defaultDate
        : event.fromDate ??
            state.fromDate; // Check if state is empty or passed is not null

    String? toDate = state.toDate.isEmpty && event.toDate == null
        ? defaultDate
        : event.toDate; // Check if state is empty or passed is not null
    emit(state.copyWith(
      status: FetchingStatus.loading,
      docstatus: event.docStatus,
      fromDate: fromDate,
      toDate: toDate,
    ));
    try {
      await repo.getAll(params: {
        "docstatus": state.docstatus,
        "from_date": state.fromDate.isEmpty
            ? DateFormat('MM/dd/yyyy').format(DateTime.now())
            : state.fromDate,
        "to_date": state.toDate.isEmpty
            ? DateFormat('MM/dd/yyyy').format(DateTime.now())
            : state.toDate,
      });
      emit(state.copyWith(status: FetchingStatus.success, datas: repo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(status: FetchingStatus.error, message: err.message));
    }
  }

  void _onCancelInAdjOut(
      CancelInAdjOut event, Emitter<InvAdjustmentOutBlocStates> emit) async {
    emit(state.copyWith(
      status: FetchingStatus.loading,
    ));
    try {
      String message = await repo.cancel(
        fk: event.id,
        canceledRemarks: event.canceledRemarks,
      );
      emit(state.copyWith(
          isCanceled: true, message: message, status: FetchingStatus.success));
    } on HttpException catch (err) {
      emit(state.copyWith(status: FetchingStatus.error, message: err.message));
    }
    emit(state.copyWith(isCanceled: false));
  }
}
