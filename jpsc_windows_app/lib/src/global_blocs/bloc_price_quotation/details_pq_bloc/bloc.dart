import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';
import '../../../utils/fetching_status.dart';

part 'events.dart';
part 'state.dart';

class FetchingPQDetailsBloc
    extends Bloc<FetchingPQDetailsEvent, FetchingPQDetailsState> {
  final PriceQuotationRepo repo;
  FetchingPQDetailsBloc(this.repo) : super(const FetchingPQDetailsState()) {
    on<FetchedPQDetails>(_onFetchedPQDetails);
  }

  void _onFetchedPQDetails(
      FetchedPQDetails event, Emitter<FetchingPQDetailsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      PriceQuotationModel? data = await repo.getDetails(fk: event.id);
      emit(state.copyWith(status: FetchingStatus.success, data: data));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
