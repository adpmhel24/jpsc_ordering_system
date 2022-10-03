import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/item/model.dart';

import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class ItemsBloc extends Bloc<ItemsBlocEvent, ItemsBlocState> {
  final ProductRepo itemRepo;
  ItemsBloc(this.itemRepo) : super(const ItemsBlocState()) {
    on<LoadItems>(_onLoadItems);
  }

  void _onLoadItems(LoadItems event, Emitter<ItemsBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await itemRepo.getAll();
      emit(state.copyWith(
          status: FetchingStatus.success, datas: itemRepo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }
}
