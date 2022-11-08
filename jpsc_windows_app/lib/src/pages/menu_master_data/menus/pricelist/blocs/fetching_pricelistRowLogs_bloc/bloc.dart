import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPricelistRowLogsBloc
    extends Bloc<FetchingPricelistRowLogsEvent, FetchingPricelistRowLogsState> {
  final PricelistRepo pricelistRepo;
  FetchingPricelistRowLogsBloc(this.pricelistRepo)
      : super(const FetchingPricelistRowLogsState()) {
    on<LoadPricelistRowLogs>(_onLoadPricelistRowLogs);
  }

  void _onLoadPricelistRowLogs(LoadPricelistRowLogs event,
      Emitter<FetchingPricelistRowLogsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      var datas = await pricelistRepo.getLogs(event.pricelistRowId);
      emit(state.copyWith(status: FetchingStatus.success, datas: datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
