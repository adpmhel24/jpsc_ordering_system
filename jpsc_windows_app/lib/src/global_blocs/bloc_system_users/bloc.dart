import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class SystemUsersBloc extends Bloc<SystemUsersBlocEvent, SystemUsersBlocState> {
  /// This bloc is For Fetching System Users
  final SystemUserRepo systemUserRepo;

  SystemUsersBloc(this.systemUserRepo) : super(const SystemUsersBlocState()) {
    on<LoadSystemUsers>(_onLoadSystemUsers);
  }

  Future<void> _onLoadSystemUsers(
      LoadSystemUsers event, Emitter<SystemUsersBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await systemUserRepo.getAllSystemUser();
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          systemUsers: systemUserRepo.datas,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          message: e.message,
        ),
      );
    }
  }
}
