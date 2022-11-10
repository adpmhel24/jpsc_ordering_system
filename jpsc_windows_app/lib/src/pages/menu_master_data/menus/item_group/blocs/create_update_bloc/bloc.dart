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

class CreateUpdateItemGroupBloc
    extends Bloc<CreateUpdateItemGroupEvent, CreateUpdateItemGroupState> {
  final ItemGroupRepo itemGroupRepo;
  final ItemGroupModel? selectedItemGroup;

  CreateUpdateItemGroupBloc({
    required this.itemGroupRepo,
    this.selectedItemGroup,
  }) : super((selectedItemGroup != null)
            ? CreateUpdateItemGroupState(
                code: FormzString.dirty(selectedItemGroup.code),
                description:
                    FormzString.dirty(selectedItemGroup.description ?? ""),
                isActive: FormzBool.dirty(selectedItemGroup.isActive),
              )
            : const CreateUpdateItemGroupState()) {
    on<CodeChanged>(_onCodeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onCodeChanged(
      CodeChanged event, Emitter<CreateUpdateItemGroupState> emit) {
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
      DescriptionChanged event, Emitter<CreateUpdateItemGroupState> emit) {
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
      IsActiveChanged event, Emitter<CreateUpdateItemGroupState> emit) {
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

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<CreateUpdateItemGroupState> emit) async {
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message;
      if (selectedItemGroup != null) {
        message =
            await itemGroupRepo.update(fk: selectedItemGroup!.code, data: data);
      } else {
        message = await itemGroupRepo.create(data);
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }
}
