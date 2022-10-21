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
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;

  SystemUsersBloc({
    required this.systemUserRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const SystemUsersBlocState()) {
    on<LoadSystemUsers>(_onLoadSystemUsers);
  }

  Future<void> _onLoadSystemUsers(
      LoadSystemUsers event, Emitter<SystemUsersBlocState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("System User");
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
        await systemUserRepo.getAllSystemUser();

        emit(
          state.copyWith(
            status: FetchingStatus.success,
            systemUsers: systemUserRepo.datas,
          ),
        );
      }
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          message: e.message,
        ),
      );
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
