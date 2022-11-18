import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingCustomersBloc
    extends Bloc<FetchingCustomersEvents, FetchingCustomersStates> {
  CustomerRepo customerRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  FetchingCustomersBloc({
    required this.customerRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const FetchingCustomersStates()) {
    on<FetchCustomers>(_onFetchCustomers);
    on<OfflineSearchCustomerByKeyword>(_onOfflineSearchCustomerByKeyword);
  }

  void _onFetchCustomers(
      FetchCustomers event, Emitter<FetchingCustomersStates> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Customer Data");
      Map<String, dynamic> auths = {};
      if (!event.params!["is_approved"]) {
        // Query for approval
        auths = {"full": true, "approve": true};
      } else {
        auths = {"full": true, "create": true, "read": true};
      }
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: auths,
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        await customerRepo.getAll(params: event.params);
        emit(
          state.copyWith(
            status: FetchingStatus.success,
            datas: customerRepo.datas,
          ),
        );
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

  void _onOfflineSearchCustomerByKeyword(OfflineSearchCustomerByKeyword event,
      Emitter<FetchingCustomersStates> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Customer Data");
      Map<String, dynamic> auths = {};
      auths = {"full": true, "read": true};
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: auths,
      );
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        List<CustomerModel> datas =
            await customerRepo.offlineSearch(event.value);
        emit(
          state.copyWith(status: FetchingStatus.success, datas: datas),
        );
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
