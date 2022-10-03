import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class UomsBloc extends Bloc<UomsBlocEvent, UomsBlocState> {
  final UomRepo uomRepo;
  UomsBloc(this.uomRepo) : super(const UomsBlocState()) {
    on<LoadUoms>(_onLoadUoms);
  }

  void _onLoadUoms(LoadUoms event, Emitter<UomsBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await uomRepo.getAll();
      emit(state.copyWith(status: FetchingStatus.success, uoms: uomRepo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }
}
