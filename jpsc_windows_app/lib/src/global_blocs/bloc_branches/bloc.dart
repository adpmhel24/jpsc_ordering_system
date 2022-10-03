import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class BranchesBloc extends Bloc<BranchesBlocEvent, BranchesBlocState> {
  final BranchRepo _branchRepo;

  BranchesBloc(this._branchRepo) : super(const BranchesBlocState()) {
    on<LoadBranches>(_onLoadBranches);
    // on<BranchesFetchingReq>(_onBranchesFetchingReq);
    // on<BranchesPauseFetchingReq>(_onBranchesPauseFetchingReq);
  }

  // void _onBranchesFetchingReq(
  //     BranchesFetchingReq event, Emitter<BranchesBlocState> emit) {
  //   emit(state.copyWith(status: FetchingStatus.loading));
  //   if (_periodicSubscription == null) {
  //     _periodicSubscription =
  //         Stream.periodic(Duration(seconds: initialDuration), (x) => x).listen(
  //       (event) => add(
  //         LoadBranches(),
  //       ),
  //     );
  //   } else {
  //     _periodicSubscription?.resume();
  //   }
  // }

  // void _onBranchesPauseFetchingReq(
  //     BranchesPauseFetchingReq event, Emitter<BranchesBlocState> emit) {
  //   _periodicSubscription?.pause();
  // }

  void _onLoadBranches(
      LoadBranches event, Emitter<BranchesBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      await _branchRepo.getAll();
      emit(state.copyWith(
          status: FetchingStatus.success, branches: _branchRepo.datas));
    } on HttpException catch (e) {
      // _periodicSubscription?.pause();
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }

  // @override
  // Future<void> close() {
  //   _periodicSubscription?.cancel();
  //   return super.close();
  // }
}
