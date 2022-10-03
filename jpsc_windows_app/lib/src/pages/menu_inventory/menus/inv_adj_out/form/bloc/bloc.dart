import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:crypto/crypto.dart';
import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class InvAdjustmentOutFormBloc
    extends Bloc<InvAdjustmentOutFormEvent, InvAdjustmentOutFormState> {
  InvAdjustmentOutRepo invAdjOutRepo;
  InvAdjustmentOutFormBloc(this.invAdjOutRepo)
      : super(const InvAdjustmentOutFormState()) {
    on<TransdateChanged>(_onTransdateChanged);
    on<RemarksChanged>(_onRemarksChanged);
    on<BranchChanged>(_onBranchChanged);
    on<AddRowItem>(_onAddRowItem);
    on<DeleteRowItem>(_onDeleteRowItem);
    on<UpdateRowItem>(_onUpdateRowItem);
    on<NewInvAdjustmentOutSubmitted>(_onNewInvAdjustmentOutSubmitted);
  }

  void _onTransdateChanged(
      TransdateChanged event, Emitter<InvAdjustmentOutFormState> emit) {
    final String transdate = event.transdate;
    emit(
      state.copyWith(
        transdate: transdate,
        status: (state.itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([state.branch]),
      ),
    );
  }

  void _onBranchChanged(
      BranchChanged event, Emitter<InvAdjustmentOutFormState> emit) {
    final FormzString branch = FormzString.dirty(event.branch);
    emit(
      state.copyWith(
        branch: branch,
        status: (state.itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([branch]),
      ),
    );
  }

  void _onRemarksChanged(
      RemarksChanged event, Emitter<InvAdjustmentOutFormState> emit) {
    final FormzString remarks = FormzString.dirty(event.remarksController.text);
    emit(
      state.copyWith(
        remarks: remarks,
        status: (state.itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([state.branch]),
      ),
    );
  }

  void _onAddRowItem(
      AddRowItem event, Emitter<InvAdjustmentOutFormState> emit) {
    List<InventoryAdjustmentOutRow> itemRows = [];

    if (state.itemRows.isNotEmpty) {
      itemRows = [...state.itemRows];

      // Get the index it the itemCode was already added to the list
      int index = itemRows.indexWhere((item) => item == event.rowItem);

      // if the index is ge of 0 then replace the current index else add to the list.
      if (index >= 0) {
        itemRows[index] = event.rowItem;
      } else {
        itemRows.add(event.rowItem);
      }
    } else {
      itemRows.add(event.rowItem);
    }
    emit(
      state.copyWith(
        itemRows: itemRows,
        status: (itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([state.branch]),
      ),
    );
  }

  void _onDeleteRowItem(
      DeleteRowItem event, Emitter<InvAdjustmentOutFormState> emit) {
    List<InventoryAdjustmentOutRow> itemRows = [];

    if (state.itemRows.isNotEmpty) {
      itemRows = [...state.itemRows];
      itemRows.remove(event.rowItem);
    }

    emit(
      state.copyWith(
        itemRows: itemRows,
        status: (itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([state.branch]),
      ),
    );
  }

  void _onUpdateRowItem(
      UpdateRowItem event, Emitter<InvAdjustmentOutFormState> emit) {
    List<InventoryAdjustmentOutRow> itemRows = [];

    if (state.itemRows.isNotEmpty) {
      itemRows = [...state.itemRows];
      int index = itemRows.indexWhere((item) => item == event.oldItem);
      itemRows[index] = event.newItem;
    }

    emit(
      state.copyWith(
        itemRows: itemRows,
        status: (itemRows.isEmpty)
            ? FormzStatus.invalid
            : Formz.validate([state.branch]),
      ),
    );
  }

  void _onNewInvAdjustmentOutSubmitted(NewInvAdjustmentOutSubmitted event,
      Emitter<InvAdjustmentOutFormState> emit) async {
    Map<String, dynamic> data = {
      "header_schema": {
        "transdate": state.transdate,
        "remarks": state.remarks.value,
        "hashed_id": sha256.convert(utf8.encode(state.transdate!)).toString(),
        "branch": state.branch.value,
      },
      "rows_schema": state.itemRows
          .map((e) => {
                "item_code": e.itemCode,
                "item_description": e.itemDescription,
                "whsecode": e.whsecode,
                "quantity": e.quantity,
                "uom": e.uom,
              })
          .toList(),
    };
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message = await invAdjOutRepo.create(data);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          responseMessage: message,
        ),
      );
    } on HttpException catch (err) {
      emit(
        state.copyWith(
          responseMessage: err.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
