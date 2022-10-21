import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class BranchesBloc extends Bloc<BranchesBlocEvent, BranchesBlocState> {
  final BranchRepo branchRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;

  BranchesBloc({
    required this.branchRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const BranchesBlocState()) {
    on<LoadBranches>(_onLoadBranches);
  }

  void _onLoadBranches(
      LoadBranches event, Emitter<BranchesBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Branch");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {"full": true, "create": true},
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        await branchRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, branches: branchRepo.datas));
      }
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
