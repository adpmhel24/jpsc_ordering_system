import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';
import '../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPriceQuotationHeaderBloc extends Bloc<
    FetchingPriceQuotationHeaderEvent, FetchingPriceQuotationHeaderState> {
  final PriceQuotationRepo priceQuotationRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  FetchingPriceQuotationHeaderBloc({
    required this.priceQuotationRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const FetchingPriceQuotationHeaderState()) {
    on<FetchAllPriceQuotationHeader>(_onFetchAllPriceQuotationHeader);
  }

  void _onFetchAllPriceQuotationHeader(FetchAllPriceQuotationHeader event,
      Emitter<FetchingPriceQuotationHeaderState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    Map<String, dynamic> auths = {};

    if (event.pqStatus == 0) {
      auths = {"full": true, "approve": true};
    } else {
      auths = {"full": true, "read": true, "update": true, "create": true};
    }

    final Map<String, dynamic> params = {
      "from_date": event.fromDate,
      "to_date": event.toDate,
      if (event.pqStatus != null) "pq_status": event.pqStatus,
      "docstatus": event.docStatus,
      "branch": event.branch == "All" ? "" : event.branch,
    };

    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Price Quotation");
      bool isAuthorized =
          currUserRepo.checkIfUserAuthorized(objtype: objType, auths: auths);
      if (!isAuthorized) {
        emit(
          state.copyWith(
            status: FetchingStatus.unauthorized,
            message: "Unauthorized user.",
          ),
        );
      } else {
        // Get all price quotation
        await priceQuotationRepo.getAll(params: params);
        emit(
          state.copyWith(
            status: FetchingStatus.success,
            datas: priceQuotationRepo.datas,
            forPriceConfirmation: priceQuotationRepo.forPriceConf,
            forCreditConfirmation: priceQuotationRepo.forCreditConf,
            forDispatch: priceQuotationRepo.forDispatch,
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
