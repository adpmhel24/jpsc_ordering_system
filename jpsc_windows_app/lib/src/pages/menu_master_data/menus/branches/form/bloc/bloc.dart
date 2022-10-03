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

class BranchFormBloc extends Bloc<BranchFormEvent, BranchFormState> {
  BranchRepo branchRepo;
  BranchModel? selectedBranch;

  BranchFormBloc({
    required this.branchRepo,
    this.selectedBranch,
  }) : super(const BranchFormState()) {
    on<BranchCodeChanged>(_onBranchCodeChanged);
    on<BranchDescriptionChanged>(_onBranchDescriptionChanged);
    on<BranchIsActiveChanged>(_onBranchIsActiveChanged);
    on<BranchPricelistChanged>(_onBranchPricelistChanged);
    on<CreateButtonSubmitted>(_onCreateButtonSubmitted);
    on<UpdateButtonSubmitted>(_onUpdateButtonSubmitted);
  }

  void _onBranchCodeChanged(
      BranchCodeChanged event, Emitter<BranchFormState> emit) {
    FormzString code;
    FormzStatus status;
    String branchName = event.nameController.text;

    if (selectedBranch != null) {
      code = FormzString.dirty(branchName);

      status = Formz.validate([
        if (code.value != selectedBranch?.code) code,
        if (!state.isActive.pure) state.isActive,
      ]);
    } else {
      code = FormzString.dirty(branchName);
      status = Formz.validate([
        code,
      ]);
    }

    emit(state.copyWith(code: code, status: status));
  }

  void _onBranchDescriptionChanged(
      BranchDescriptionChanged event, Emitter<BranchFormState> emit) {
    FormzString description;
    FormzStatus status;
    String branchDescription = event.descriptionController.text;

    if (selectedBranch != null) {
      description = selectedBranch!.description == branchDescription
          ? const FormzString.pure()
          : FormzString.dirty(branchDescription);
      status = Formz.validate([
        if (!state.code.pure) state.code,
        if (!state.isActive.pure) state.isActive,
      ]);
    } else {
      description = FormzString.dirty(branchDescription);
      status = Formz.validate([
        state.code,
      ]);
    }

    emit(state.copyWith(description: description, status: status));
  }

  void _onBranchPricelistChanged(
      BranchPricelistChanged event, Emitter<BranchFormState> emit) {
    FormzString pricelistCode;
    FormzStatus status;
    String branchPricelist = event.pricelistCodeController.text;

    if (selectedBranch != null) {
      pricelistCode = selectedBranch!.pricelistCode == branchPricelist
          ? const FormzString.pure()
          : FormzString.dirty(branchPricelist);
      status = Formz.validate([
        if (!state.code.pure) state.code,
        if (!state.isActive.pure) state.isActive,
      ]);
    } else {
      pricelistCode = FormzString.dirty(branchPricelist);
      status = Formz.validate([
        state.code,
      ]);
    }

    emit(state.copyWith(pricelistCode: pricelistCode, status: status));
  }

  void _onBranchIsActiveChanged(
      BranchIsActiveChanged event, Emitter<BranchFormState> emit) {
    FormzBool isActive;
    FormzStatus status;
    bool? branchIsActive = event.isActive;

    if (selectedBranch != null) {
      isActive = FormzBool.dirty(branchIsActive);

      status = Formz.validate([
        if (!state.code.pure) state.code,
        if (!isActive.pure) isActive,
      ]);
    } else {
      isActive = FormzBool.dirty(branchIsActive);
      status = Formz.validate([
        state.code,
        isActive,
      ]);
    }

    emit(
      state.copyWith(
        isActive: isActive,
        status: status,
      ),
    );
  }

  void _onCreateButtonSubmitted(
      CreateButtonSubmitted event, Emitter<BranchFormState> emit) async {
    String? pricelistCode =
        state.pricelistCode.valid ? state.pricelistCode.value : null;
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
      "pricelist_code": pricelistCode,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message = await branchRepo.createBranch(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }

  void _onUpdateButtonSubmitted(
      UpdateButtonSubmitted event, Emitter<BranchFormState> emit) async {
    String code = state.code.value;
    String description = state.description.value;
    bool? isActive = state.isActive.value;
    String pricelistCode = state.pricelistCode.value;
    Map<String, dynamic> data = {
      "code": code.isEmpty ? selectedBranch!.code : state.code.value,
      "description": description.isEmpty
          ? selectedBranch!.description
          : state.description.value,
      "is_active":
          isActive == null ? selectedBranch!.isActive : state.isActive.value,
      "pricelist_code":
          pricelistCode.isEmpty ? selectedBranch!.pricelistCode : pricelistCode,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message =
          await branchRepo.update(branchCode: selectedBranch!.code, data: data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: err.message));
    }
  }
}
