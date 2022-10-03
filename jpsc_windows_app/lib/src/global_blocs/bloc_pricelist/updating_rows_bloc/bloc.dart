import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class PricelistRowsUpdateBloc
    extends Bloc<PricelistRowsUpdateEvent, PricelistRowsUpdateState> {
  final PricelistRepo _pricelistRepo;
  PricelistRowsUpdateBloc(this._pricelistRepo)
      : super(const PricelistRowsUpdateState()) {
    on<UpdateSubmitted>(_onUpdateSubmitted);
  }

  void _onUpdateSubmitted(
      UpdateSubmitted event, Emitter<PricelistRowsUpdateState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      String message =
          await _pricelistRepo.bulkUpdatePricelistRow(datas: event.items);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    }
  }
}
