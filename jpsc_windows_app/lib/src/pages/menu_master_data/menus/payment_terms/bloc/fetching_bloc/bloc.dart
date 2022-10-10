import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPaymentTermsBloc
    extends Bloc<FetchingPaymentTermsEvent, FetchingPaymentTermsState> {
  final PaymentTermRepo _repo;
  FetchingPaymentTermsBloc(this._repo)
      : super(const FetchingPaymentTermsState()) {
    on<LoadPaymentTerms>(_onLoadPaymentTerms);
  }

  void _onLoadPaymentTerms(
      LoadPaymentTerms event, Emitter<FetchingPaymentTermsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await _repo.getAll();
      emit(state.copyWith(status: FetchingStatus.success, datas: _repo.datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
