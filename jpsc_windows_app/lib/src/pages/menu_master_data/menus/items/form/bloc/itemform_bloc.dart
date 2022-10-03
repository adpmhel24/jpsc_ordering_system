import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_bool.dart';
import '../../../../../../utils/formz_string.dart';

part 'itemform_event.dart';
part 'itemform_state.dart';

class ItemFormBloc extends Bloc<ItemFormEvent, ItemFormState> {
  final ProductRepo itemRepo;
  final ProductModel? selectedItem;
  ItemFormBloc({
    required this.itemRepo,
    this.selectedItem,
  }) : super(const ItemFormState()) {
    on<CodeChanged>(_onCodeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<ItemGroupChanged>(_onItemGroupChanged);

    on<SaleUomChanged>(_onSaleUomChanged);

    on<IsActiveChanged>(_onIsActiveChanged);
    on<CreateButtonSubmitted>(_onCreateButtonSubmitted);
  }

  void _onCodeChanged(CodeChanged event, Emitter<ItemFormState> emit) {
    final code = FormzString.dirty(event.name.text);
    emit(
      state.copyWith(
        code: code,
        status: Formz.validate(
          [
            code,
            state.formzItemGroup,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<ItemFormState> emit) {
    final formzDescription = FormzString.dirty(event.description.text);
    emit(
      state.copyWith(
        formzDescription: formzDescription,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onItemGroupChanged(
      ItemGroupChanged event, Emitter<ItemFormState> emit) {
    final formzItemGroup = FormzString.dirty(event.itemGrp.text);

    emit(
      state.copyWith(
        formzItemGroup: formzItemGroup,
        status: Formz.validate(
          [
            state.code,
            formzItemGroup,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onSaleUomChanged(SaleUomChanged event, Emitter<ItemFormState> emit) {
    final formzSaleUom = FormzString.dirty(event.saleUom.text);
    emit(
      state.copyWith(
        formzSaleUom: formzSaleUom,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onIsActiveChanged(IsActiveChanged event, Emitter<ItemFormState> emit) {
    final formzIsActive = FormzBool.dirty(event.isActive);
    emit(
      state.copyWith(
        formzIsActive: formzIsActive,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onCreateButtonSubmitted(
      CreateButtonSubmitted event, Emitter<ItemFormState> emit) async {
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.formzDescription.value,
      "item_group_code": state.formzItemGroup.value,
      "sale_uom_code": state.formzSaleUom.value,
      "is_active": state.formzIsActive.value,
    };
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var message = await itemRepo.create(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: err.message));
    }
  }
}
