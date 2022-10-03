import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/customer/model.dart';
import '../../../data/repositories/repo_customer.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class CustomerFetchingBloc
    extends Bloc<CustomerFetchingEvent, CustomerFetchingState> {
  CustomerRepo customerRepo;
  CustomerFetchingBloc(this.customerRepo)
      : super(const CustomerFetchingState()) {
    on<FetchCustomers>(_onFetchCustomers);
  }

  void _onFetchCustomers(
      FetchCustomers event, Emitter<CustomerFetchingState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      await customerRepo.getAll(params: event.params);
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          datas: customerRepo.datas,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
