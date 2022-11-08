import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class PricelistFetchingBloc
    extends Bloc<PricelistFetchingEvent, PricelistFetchingState> {
  final PricelistRepo pricelistRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  PricelistFetchingBloc({
    required this.pricelistRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const PricelistFetchingState()) {
    on<LoadPricelist>(_onLoadPricelist);
    on<FilterPricelist>(_onFilterPricelist);
  }

  void _onLoadPricelist(
      LoadPricelist event, Emitter<PricelistFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Pricelist");
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
        await pricelistRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, datas: pricelistRepo.datas));
      }
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.unauthorized,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterPricelist(
      FilterPricelist event, Emitter<PricelistFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    List<PricelistModel> datas = [];
    try {
      if (event.keyword.isNotEmpty) {
        datas = await pricelistRepo.offlineSearch(event.keyword);
      } else {
        if (pricelistRepo.datas.isEmpty) {
          await pricelistRepo.getAll();
        }
        datas = pricelistRepo.datas;
      }
      emit(state.copyWith(status: FetchingStatus.success, datas: datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }
}
