import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/item_group/model.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class ItemGroupsBloc extends Bloc<ItemGroupsBlocEvent, ItemGroupsBlocState> {
  final ItemGroupRepo itemGroupRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  ItemGroupsBloc({
    required this.itemGroupRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const ItemGroupsBlocState()) {
    on<LoadItemGroups>(_onLoadItemGroups);
  }

  void _onLoadItemGroups(
      LoadItemGroups event, Emitter<ItemGroupsBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Item Group");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {"full": true, "create": true},
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            errorMessage: "Unauthorized user.",
          ),
        );
      } else {
        await itemGroupRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, itemGroups: itemGroupRepo.datas));
      }
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    } on Exception catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.toString()));
    }
  }
}
