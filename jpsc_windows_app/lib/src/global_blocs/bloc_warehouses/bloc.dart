import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class WarehousesBloc extends Bloc<WarehousesBlocEvent, WarehousesBlocState> {
  final WarehouseRepo warehouseRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  WarehousesBloc({
    required this.warehouseRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const WarehousesBlocState()) {
    on<LoadWarehouses>(_onLoadWarehouses);
  }

  void _onLoadWarehouses(
      LoadWarehouses event, Emitter<WarehousesBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      int objType = await objectTypeRepo.getObjectTypeByName("Warehouse");
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
        await warehouseRepo.getAll();
        emit(
          state.copyWith(
            warehouses: warehouseRepo.datas,
            status: FetchingStatus.success,
          ),
        );
      }
    } on HttpException catch (err) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          errorMessage: err.message,
        ),
      );
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
