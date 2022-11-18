import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repo_app_version.dart';
import '../../../../../../utils/fetching_status.dart';

part 'events.dart';
part 'state.dart';

class FetchingAppVersionsBloc
    extends Bloc<FetchingAppVersionsEvents, FetchingAppVersionsState> {
  final AppVersionRepo repo;
  FetchingAppVersionsBloc(this.repo) : super(const FetchingAppVersionsState()) {
    on<LoadAppVersions>(onLoadAppVersions);
  }

  void onLoadAppVersions(
      LoadAppVersions event, Emitter<FetchingAppVersionsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await repo.getAll();
      emit(state.copyWith(status: FetchingStatus.success, datas: repo.datas));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
