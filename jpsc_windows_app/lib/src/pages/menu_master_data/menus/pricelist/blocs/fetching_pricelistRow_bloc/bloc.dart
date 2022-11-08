import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPriceListRowBloc
    extends Bloc<FetchingPriceListRowEvent, FetchingPriceListRowState> {
  final PricelistRepo pricelistRepo;
  final ObjectTypeRepo objectTypeRepo;
  final CurrentUserRepo currUserRepo;
  FetchingPriceListRowBloc({
    required this.pricelistRepo,
    required this.objectTypeRepo,
    required this.currUserRepo,
  }) : super(const FetchingPriceListRowState()) {
    on<LoadPricelistRowByPricelistCode>(_onLoadPricelistRowByPricelistCode);
    on<LoadPricelistRowByItemCode>(_onLoadPricelistRowByItemCode);
  }

  void _onLoadPricelistRowByPricelistCode(LoadPricelistRowByPricelistCode event,
      Emitter<FetchingPriceListRowState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Pricelist");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {"full": true, "update": true, "read": true},
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        final result = await pricelistRepo.getByPricelistCode(event.value);
        emit(
            state.copyWith(status: FetchingStatus.success, datas: result.rows));
      }
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }

  void _onLoadPricelistRowByItemCode(LoadPricelistRowByItemCode event,
      Emitter<FetchingPriceListRowState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Pricelist");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {"full": true, "update": true},
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        final result = await pricelistRepo.getByItemCode(event.value);
        emit(state.copyWith(status: FetchingStatus.success, datas: result));
      }
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
