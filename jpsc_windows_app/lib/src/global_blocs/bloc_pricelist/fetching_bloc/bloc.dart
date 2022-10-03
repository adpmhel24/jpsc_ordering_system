import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/data/repositories/repo_pricelist.dart';

import '../../../data/models/models.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class PricelistFetchingBloc
    extends Bloc<PricelistFetchingEvent, PricelistFetchingState> {
  final PricelistRepo _pricelistRepo;
  PricelistFetchingBloc(this._pricelistRepo)
      : super(const PricelistFetchingState()) {
    on<FetchAllPricelist>(_onFetchAllPricelist);
    on<FilterPricelist>(_onFilterPricelist);
  }

  void _onFetchAllPricelist(
      FetchAllPricelist event, Emitter<PricelistFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await _pricelistRepo.getAll();
      emit(state.copyWith(
          status: FetchingStatus.success, datas: _pricelistRepo.datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }

  void _onFilterPricelist(
      FilterPricelist event, Emitter<PricelistFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    List<PricelistModel> datas = [];
    try {
      if (event.keyword.isNotEmpty) {
        datas = await _pricelistRepo.offlineSearch(event.keyword);
      } else {
        if (_pricelistRepo.datas.isEmpty) {
          await _pricelistRepo.getAll();
        }
        datas = _pricelistRepo.datas;
      }
      emit(state.copyWith(status: FetchingStatus.success, datas: datas));
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    }
  }
}
