import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class ItemGroupBulkInsertBloc
    extends Bloc<ItemGroupBulkInsertEvent, ItemGroupBulkInsertState> {
  final ItemGroupRepo itemGroupRepo;
  ItemGroupBulkInsertBloc(this.itemGroupRepo)
      : super(const ItemGroupBulkInsertState()) {
    on<UploadButtonSubmitted>(onUploadButtonSubmitted);
  }

  void onUploadButtonSubmitted(UploadButtonSubmitted event,
      Emitter<ItemGroupBulkInsertState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      String message = await itemGroupRepo.bulkInsert(datas: event.value);
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
