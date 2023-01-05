import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/data/models/models.dart';

import '../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

enum AppVersionStatus { init, loading, available, noAvailable, error }

class CheckAppVersionBloc
    extends Bloc<CheckAppVersionEvent, CheckAppVersionState> {
  AppVersionRepo repo;
  CheckAppVersionBloc(this.repo) : super(const CheckAppVersionState()) {
    on<CheckingNewVersion>(_onCheckingNewVersion);
  }

  void _onCheckingNewVersion(
      CheckingNewVersion event, Emitter<CheckAppVersionState> emit) async {
    emit(state.copyWith(status: AppVersionStatus.loading));

    try {
      bool hasNewUpdate = await repo.hasNewUpdate();
      if (hasNewUpdate) {
        emit(state.copyWith(
            status: AppVersionStatus.available, data: repo.appVersion));
      } else {
        emit(state.copyWith(status: AppVersionStatus.noAvailable, data: null));
      }
    } on HttpException catch (e) {
      emit(state.copyWith(status: AppVersionStatus.error, message: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: AppVersionStatus.error, message: e.toString()));
    }
  }
}
