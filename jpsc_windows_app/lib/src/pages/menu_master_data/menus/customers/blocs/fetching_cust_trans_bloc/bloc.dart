import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';

import '../../../../../../data/models/models.dart';

part 'event.dart';
part 'state.dart';

class FetchingCustTransactionsBloc
    extends Bloc<FetchingCustTransactionsEvent, FetchingCustTransactionsState> {
  final PriceQuotationRepo repo;
  FetchingCustTransactionsBloc(this.repo)
      : super(const FetchingCustTransactionsState()) {
    on<LoadCustomerTransactions>(_onLoadCustomerTransactions);
  }

  void _onLoadCustomerTransactions(LoadCustomerTransactions event,
      Emitter<FetchingCustTransactionsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      final result = await repo.getByCustomerCode(event.customerCode, params: {
        if (event.page != null) "page": event.page,
        if (event.size != null) "size": event.size,
        if (event.fromDate != null) "from_date": event.fromDate,
        if (event.toDate != null) "to_date": event.toDate,
      });
      emit(
        state.copyWith(
          status: FetchingStatus.success,
          datas: List<PriceQuotationModel>.from(
            result["data"].map(
              (e) => PriceQuotationModel.fromJson(e),
            ),
          ).toList(),
          total: result["total"],
          rowsPerPage: result["size"],
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.toString()));
    }
  }
}
