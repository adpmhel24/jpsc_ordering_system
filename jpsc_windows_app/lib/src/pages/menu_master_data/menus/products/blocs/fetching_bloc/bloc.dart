import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingProductsBloc
    extends Bloc<FetchingProductsEvent, FetchingProductsState> {
  final ProductRepo productRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  FetchingProductsBloc({
    required this.productRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const FetchingProductsState()) {
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(
      LoadProducts event, Emitter<FetchingProductsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      int objType = await objectTypeRepo.getObjectTypeByName("Item");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {"full": true, "create": true, "read": true},
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            errorMessage: "Unauthorized user.",
          ),
        );
      } else {
        await productRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, datas: productRepo.datas));
      }
    } on HttpException catch (err) {
      emit(state.copyWith(
          status: FetchingStatus.error, errorMessage: err.message));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FetchingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
