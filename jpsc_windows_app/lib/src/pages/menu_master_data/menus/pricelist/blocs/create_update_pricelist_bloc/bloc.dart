import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/utils/formz_bool.dart';
import 'package:jpsc_windows_app/src/utils/formz_string.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class CreateUpdatePricelistBloc
    extends Bloc<CreateUpdatePricelistEvent, CreateUpdatePricelistState> {
  final PricelistRepo pricelistRepo;
  final PricelistModel? selectedPricelist;
  CreateUpdatePricelistBloc({
    required this.pricelistRepo,
    this.selectedPricelist,
  }) : super(selectedPricelist != null
            ? CreateUpdatePricelistState(
                code: FormzString.dirty(selectedPricelist.code ?? ""),
                description:
                    FormzString.dirty(selectedPricelist.description ?? ""),
                isActive: FormzBool.dirty(selectedPricelist.isActive),
                status: FormzStatus.valid,
              )
            : const CreateUpdatePricelistState()) {
    on<PricelistCodeChanged>(_onPricelistCodeChanged);
    on<PricelistDescChanged>(_onPricelistDescChanged);
    on<PricelistIsActiveChanged>(_onPricelistIsActiveChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onPricelistCodeChanged(
      PricelistCodeChanged event, Emitter<CreateUpdatePricelistState> emit) {
    final code = FormzString.dirty(event.code);
    emit(state.copyWith(code: code, status: Formz.validate([code])));
  }

  void _onPricelistDescChanged(
      PricelistDescChanged event, Emitter<CreateUpdatePricelistState> emit) {
    final description = FormzString.dirty(event.description);
    emit(state.copyWith(
        description: description, status: Formz.validate([state.code])));
  }

  void _onPricelistIsActiveChanged(PricelistIsActiveChanged event,
      Emitter<CreateUpdatePricelistState> emit) {
    final isActive = FormzBool.dirty(event.isActive);
    emit(state.copyWith(
        isActive: isActive, status: Formz.validate([state.code])));
  }

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<CreateUpdatePricelistState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    String message;

    final Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
    };

    try {
      if (selectedPricelist != null) {
        message = await pricelistRepo.update(
            fk: selectedPricelist!.code!, data: data);
      } else {
        message = await pricelistRepo.create(data);
      }
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
