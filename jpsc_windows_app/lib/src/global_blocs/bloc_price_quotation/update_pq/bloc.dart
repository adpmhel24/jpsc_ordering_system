import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class PriceQuotationUpdateBloc
    extends Bloc<PriceQuotationUpdateEvent, PriceQuotationUpdateState> {
  final PriceQuotationModel selectedPriceQuotation;
  final PriceQuotationRepo salesOrdeRepo;
  PriceQuotationUpdateBloc(
      {required this.selectedPriceQuotation, required this.salesOrdeRepo})
      : super(
            PriceQuotationUpdateState(priceQuotation: selectedPriceQuotation)) {
    on<DispatchBranchChanged>(_onDispatchBranchChanged);
    on<OrderStatusChanged>(_onOrderStatusChanged);
    on<SQNumberChanged>(_onSQNumberChanged);
    on<PriceQuotationRemarksChanged>(_onPriceQuotationRemarksChanged);
    on<PriceQuotationRowsChanged>(_onPriceQuotationRowsChanged);
    on<PriceQuotationUpdateSubmitted>(_onPriceQuotationUpdateSubmitted);
    on<PaymentTermsChanged>(_onPaymentTermsChanged);
  }

  void _onDispatchBranchChanged(
      DispatchBranchChanged event, Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.dispatchingBranch = event.dispatchingBranch;
    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onSQNumberChanged(
      SQNumberChanged event, Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.sqNumber = event.sqNumber;
    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onOrderStatusChanged(
      OrderStatusChanged event, Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.pqStatus = event.pqStatus;
    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onPaymentTermsChanged(
      PaymentTermsChanged event, Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.paymentTerms = event.value;
    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onPriceQuotationRemarksChanged(PriceQuotationRemarksChanged event,
      Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.remarks = event.remarks;
    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onPriceQuotationRowsChanged(PriceQuotationRowsChanged event,
      Emitter<PriceQuotationUpdateState> emit) {
    PriceQuotationModel priceQuotation =
        PriceQuotationModel.fromJson(state.priceQuotation.toJson());
    priceQuotation.rows = event.priceQuotationRows;
    double subtotal = 0;
    double gross = 0;

    for (var e in event.priceQuotationRows) {
      subtotal += e.linetotal;
      gross = subtotal;
    }
    priceQuotation.subtotal = subtotal;
    priceQuotation.gross = gross;

    emit(state.copyWith(priceQuotation: priceQuotation));
  }

  void _onPriceQuotationUpdateSubmitted(PriceQuotationUpdateSubmitted event,
      Emitter<PriceQuotationUpdateState> emit) async {
    emit(state.copyWith(status: FetchingStatus.loading));

    try {
      String message =
          await salesOrdeRepo.update(data: state.priceQuotation.toJson());
      emit(state.copyWith(status: FetchingStatus.success, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(status: FetchingStatus.error, message: e.message));
    }
  }
}
