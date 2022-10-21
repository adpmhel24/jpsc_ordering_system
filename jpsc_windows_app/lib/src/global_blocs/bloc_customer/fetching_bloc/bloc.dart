import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/customer/model.dart';
import '../../../data/repositories/repos.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class CustomerFetchingBloc
    extends Bloc<CustomerFetchingEvent, CustomerFetchingState> {
  CustomerRepo customerRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  CustomerFetchingBloc({
    required this.customerRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const CustomerFetchingState()) {
    on<FetchCustomers>(_onFetchCustomers);
  }

  void _onFetchCustomers(
      FetchCustomers event, Emitter<CustomerFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Customer Data");
      bool isAuthorized = currUserRepo.checkIfUserAuthorized(
        objtype: objType,
        auths: {
          "full": true,
          "create": true,
          if (!event.params!["is_approved"]) "approve": true,
        },
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
}
