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

class CreateUpdateProductBloc
    extends Bloc<CreateUpdateProductEvent, CreateUpdateProductState> {
  final ProductRepo itemRepo;
  final ProductModel? selectedItem;
  CreateUpdateProductBloc({
    required this.itemRepo,
    this.selectedItem,
  }) : super(selectedItem != null
            ? CreateUpdateProductState(
                code: FormzString.dirty(selectedItem.code),
                formzDescription:
                    FormzString.dirty(selectedItem.description ?? ""),
                formzItemGroup:
                    FormzString.dirty(selectedItem.itemGroupCode ?? ""),
                formzSaleUom: FormzString.dirty(selectedItem.saleUomCode ?? ""),
                formzIsActive: FormzBool.dirty(selectedItem.isActive),
                status: Formz.validate(
                  [
                    FormzString.dirty(selectedItem.code),
                    FormzString.dirty(selectedItem.itemGroupCode ?? ""),
                    FormzString.dirty(selectedItem.saleUomCode ?? ""),
                  ],
                ),
              )
            : const CreateUpdateProductState()) {
    on<CodeChanged>(_onCodeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<ItemGroupChanged>(_onItemGroupChanged);
    on<SaleUomChanged>(_onSaleUomChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onCodeChanged(
      CodeChanged event, Emitter<CreateUpdateProductState> emit) {
    final code = FormzString.dirty(event.name.text);
    emit(
      state.copyWith(
        code: code,
        status: Formz.validate(
          [
            code,
            state.formzItemGroup,
            state.formzSaleUom,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<CreateUpdateProductState> emit) {
    final formzDescription = FormzString.dirty(event.description.text);
    emit(
      state.copyWith(
        formzDescription: formzDescription,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            state.formzSaleUom,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onItemGroupChanged(
      ItemGroupChanged event, Emitter<CreateUpdateProductState> emit) {
    final formzItemGroup = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        formzItemGroup: formzItemGroup,
        status: Formz.validate(
          [
            state.code,
            formzItemGroup,
            state.formzSaleUom,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onSaleUomChanged(
      SaleUomChanged event, Emitter<CreateUpdateProductState> emit) {
    final formzSaleUom = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        formzSaleUom: formzSaleUom,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            formzSaleUom,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onIsActiveChanged(
      IsActiveChanged event, Emitter<CreateUpdateProductState> emit) {
    final formzIsActive = FormzBool.dirty(event.isActive);
    emit(
      state.copyWith(
        formzIsActive: formzIsActive,
        status: Formz.validate(
          [
            state.code,
            state.formzItemGroup,
            state.formzSaleUom,
            state.formzIsActive,
          ],
        ),
      ),
    );
  }

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<CreateUpdateProductState> emit) async {
    String message;
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.formzDescription.value,
      "item_group_code": state.formzItemGroup.value,
      "sale_uom_code": state.formzSaleUom.value,
      "is_active": state.formzIsActive.value,
    };
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (selectedItem != null) {
        message = await itemRepo.update(fk: selectedItem!.code, data: data);
      } else {
        message = await itemRepo.create(data);
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: err.message));
    }
  }
}
