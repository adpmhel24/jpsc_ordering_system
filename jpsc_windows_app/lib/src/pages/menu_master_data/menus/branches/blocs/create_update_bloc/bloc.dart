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

class CreateUpdateBranchBloc
    extends Bloc<CreateUpdateBranchEvent, CreateUpdateBranchState> {
  BranchRepo branchRepo;
  BranchModel? selectedBranch;

  CreateUpdateBranchBloc({
    required this.branchRepo,
    this.selectedBranch,
  }) : super((selectedBranch != null)
            ? CreateUpdateBranchState(
                code: FormzString.dirty(selectedBranch.code),
                description:
                    FormzString.dirty(selectedBranch.description ?? ""),
                pricelistCode:
                    FormzString.dirty(selectedBranch.pricelistCode ?? ""),
                isActive: FormzBool.dirty(selectedBranch.isActive),
              )
            : const CreateUpdateBranchState()) {
    on<BranchCodeChanged>(_onBranchCodeChanged);
    on<BranchDescriptionChanged>(_onBranchDescriptionChanged);
    on<BranchIsActiveChanged>(_onBranchIsActiveChanged);
    on<BranchPricelistChanged>(_onBranchPricelistChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onBranchCodeChanged(
      BranchCodeChanged event, Emitter<CreateUpdateBranchState> emit) {
    final code = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        code: code,
        status: Formz.validate(
          [
            code,
            state.pricelistCode,
          ],
        ),
      ),
    );
  }

  void _onBranchDescriptionChanged(
      BranchDescriptionChanged event, Emitter<CreateUpdateBranchState> emit) {
    final description = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate(
          [
            state.code,
            state.pricelistCode,
          ],
        ),
      ),
    );
  }

  void _onBranchPricelistChanged(
      BranchPricelistChanged event, Emitter<CreateUpdateBranchState> emit) {
    final pricelistCode = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        pricelistCode: pricelistCode,
        status: Formz.validate(
          [
            state.code,
            pricelistCode,
          ],
        ),
      ),
    );
  }

  void _onBranchIsActiveChanged(
      BranchIsActiveChanged event, Emitter<CreateUpdateBranchState> emit) {
    final isActive = FormzBool.dirty(event.value);
    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate(
          [
            state.code,
            state.pricelistCode,
          ],
        ),
      ),
    );
  }

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<CreateUpdateBranchState> emit) async {
    String? pricelistCode =
        state.pricelistCode.valid ? state.pricelistCode.value : null;
    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
      "is_active": state.isActive.value,
      "pricelist_code": pricelistCode,
    };
    String message;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (selectedBranch == null) {
        message = await branchRepo.createBranch(data);
      } else {
        message = await branchRepo.update(
            branchCode: selectedBranch!.code, data: data);
      }
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}
