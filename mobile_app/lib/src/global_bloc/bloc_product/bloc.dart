import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/data/repositories/repos.dart';

import '../../data/models/models.dart';
import '../../screens/utils/fetching_status.dart';

part 'events.dart';
part 'states.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepo _productsRepo;

  ProductsBloc(this._productsRepo) : super(const ProductsState()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchProductWithPriceByLocation>(_onFetchProductWithPriceByLocation);
    on<SearchProductByKeyword>(_onSearchProductByKeyword);
  }

  void _onFetchAllProducts(
      FetchAllProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await _productsRepo.getAll();
      emit(state.copyWith(
          status: FetchingStatus.success, products: _productsRepo.datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }

  void _onFetchProductWithPriceByLocation(FetchProductWithPriceByLocation event,
      Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await _productsRepo.getItemWithPriceByBranch(event.location);
      emit(state.copyWith(
          status: FetchingStatus.success, products: _productsRepo.datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }

  void _onSearchProductByKeyword(
      SearchProductByKeyword event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      var datas = await _productsRepo.offlineSearch(keyword: event.keyword);
      emit(state.copyWith(status: FetchingStatus.success, products: datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
