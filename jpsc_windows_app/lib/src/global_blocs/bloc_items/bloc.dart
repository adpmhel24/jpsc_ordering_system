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
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  ItemsBloc({
    required this.itemRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const ItemsBlocState()) {
    on<LoadItems>(_onLoadItems);
  }

  void _onLoadItems(LoadItems event, Emitter<ItemsBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      int objType = await objectTypeRepo.getObjectTypeByName("Item");
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
        await itemRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, datas: itemRepo.datas));
      }
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
