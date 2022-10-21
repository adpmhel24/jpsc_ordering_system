import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/fetching_status.dart';

part 'event.dart';
part 'state.dart';

class FetchingPaymentTermsBloc
    extends Bloc<FetchingPaymentTermsEvent, FetchingPaymentTermsState> {
  final PaymentTermRepo paymentTermRepo;
  final CurrentUserRepo currUserRepo;
  final ObjectTypeRepo objectTypeRepo;
  FetchingPaymentTermsBloc({
    required this.paymentTermRepo,
    required this.currUserRepo,
    required this.objectTypeRepo,
  }) : super(const FetchingPaymentTermsState()) {
    on<LoadPaymentTerms>(_onLoadPaymentTerms);
  }

  void _onLoadPaymentTerms(
      LoadPaymentTerms event, Emitter<FetchingPaymentTermsState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));
    try {
      // Check if authorized
      int objType = await objectTypeRepo.getObjectTypeByName("Payment Terms");
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
        await paymentTermRepo.getAll();
        emit(state.copyWith(
            status: FetchingStatus.success, datas: paymentTermRepo.datas));
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
