import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_bool.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class CreateUpdateUomBloc
    extends Bloc<CreateUpdateUomEvent, CreateUpdateUomState> {
  final UomRepo uomRepo;
  final UomModel? selectedUom;

  CreateUpdateUomBloc({
    required this.uomRepo,
    this.selectedUom,
  }) : super(selectedUom != null
            ? CreateUpdateUomState(
                code: FormzString.dirty(selectedUom.code),
                description: FormzString.dirty(selectedUom.description ?? ""),
                isActive: FormzBool.dirty(selectedUom.isActive),
              )
            : const CreateUpdateUomState()) {
    on<CodeChanged>(_onCodeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onCodeChanged(CodeChanged event, Emitter<CreateUpdateUomState> emit) {
    FormzString code = FormzString.dirty(event.value);
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
      DescriptionChanged event, Emitter<CreateUpdateUomState> emit) {
    FormzString description = FormzString.dirty(event.value);
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
      IsActiveChanged event, Emitter<CreateUpdateUomState> emit) {
    FormzBool isActive = FormzBool.dirty(event.value);
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
      ButtonSubmitted event, Emitter<CreateUpdateUomState> emit) async {
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
    };
    String message;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (selectedUom == null) {
        message = await uomRepo.create(data);
      } else {
        message = await uomRepo.update(fk: selectedUom!.code, data: data);
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }
}
