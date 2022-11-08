import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_bool.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class UomFormBloc extends Bloc<UomFormBlocEvent, UomFormBlocState> {
  final UomRepo uomRepo;
  final UomModel? selectedUom;

  UomFormBloc({
    required this.uomRepo,
    this.selectedUom,
  }) : super(const UomFormBlocState()) {
    on<CodeChanged>(_onCodeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<CreateButtonSubmitted>(_onCreateButtonSubmitted);
    on<UpdateButtonSubmitted>(_onUpdateButtonSubmitted);
  }

  void _onCodeChanged(CodeChanged event, Emitter<UomFormBlocState> emit) {
    FormzString code = FormzString.dirty(event.codeController.text);
    emit(
      state.copyWith(
        code: code,
        status: Formz.validate(
          [
            code,
            state.description,
            state.isActive,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<UomFormBlocState> emit) {
    FormzString description =
        FormzString.dirty(event.descriptionController.text);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate(
          [
            state.code,
            description,
            state.isActive,
          ],
        ),
      ),
    );
  }

  void _onIsActiveChanged(
      IsActiveChanged event, Emitter<UomFormBlocState> emit) {
    FormzBool isActive = FormzBool.dirty(event.isActive);
    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate(
          [
            state.code,
            state.description,
            isActive,
          ],
        ),
      ),
    );
  }

  void _onCreateButtonSubmitted(
      CreateButtonSubmitted event, Emitter<UomFormBlocState> emit) async {
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message = await uomRepo.create(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }

  void _onUpdateButtonSubmitted(
      UpdateButtonSubmitted event, Emitter<UomFormBlocState> emit) async {
    String code = state.code.value;
    String description = state.description.value;
    bool? isActive = state.isActive.value;
    Map<String, dynamic> data = {
      "code": code.isEmpty ? selectedUom!.code : state.code.value,
      "description": description.isEmpty
          ? selectedUom!.description
          : state.description.value,
      "is_active":
          isActive == null ? selectedUom!.isActive : state.isActive.value,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message = await uomRepo.update(fk: selectedUom!.code, data: data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }
}
