import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/item_group/model.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class ItemGroupsBloc extends Bloc<ItemGroupsBlocEvent, ItemGroupsBlocState> {
  ItemGroupRepo itemGroupRepo;
  ItemGroupsBloc(this.itemGroupRepo) : super(const ItemGroupsBlocState()) {
    on<LoadItemGroups>(_onLoadItemGroups);
  }

  void _onLoadItemGroups(
      LoadItemGroups event, Emitter<ItemGroupsBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await itemGroupRepo.getAll();
      emit(state.copyWith(
          status: FetchingStatus.success, itemGroups: itemGroupRepo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }
}
