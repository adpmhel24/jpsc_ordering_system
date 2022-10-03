import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/utils/formz_bool.dart';
import 'package:jpsc_windows_app/src/utils/formz_string.dart';

import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class PricelistCreateBloc
    extends Bloc<PricelistCreateEvent, PricelistCreateState> {
  final PricelistRepo _pricelistRepo;
  PricelistCreateBloc(this._pricelistRepo)
      : super(const PricelistCreateState()) {
    on<PricelistCodeChanged>(_onPricelistCodeChanged);
    on<PricelistDescChanged>(_onPricelistDescChanged);
    on<PricelistIsActiveChanged>(_onPricelistIsActiveChanged);
    on<PriceListCreateSubmitted>(_onPriceListCreateSubmitted);
  }

  void _onPricelistCodeChanged(
      PricelistCodeChanged event, Emitter<PricelistCreateState> emit) {
    final code = FormzString.dirty(event.code);
    emit(state.copyWith(code: code, status: Formz.validate([code])));
  }

  void _onPricelistDescChanged(
      PricelistDescChanged event, Emitter<PricelistCreateState> emit) {
    final description = FormzString.dirty(event.description);
    emit(state.copyWith(
        description: description, status: Formz.validate([state.code])));
  }

  void _onPricelistIsActiveChanged(
      PricelistIsActiveChanged event, Emitter<PricelistCreateState> emit) {
    final isActive = FormzBool.dirty(event.isActive);
    emit(state.copyWith(
        isActive: isActive, status: Formz.validate([state.code])));
  }

  void _onPriceListCreateSubmitted(PriceListCreateSubmitted event,
      Emitter<PricelistCreateState> emit) async {
    final Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      String message = await _pricelistRepo.create(data);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: message,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        ),
      );
    }
  }
}
