import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/repositories/repos.dart';
import '../../../screens/utils/formz_double.dart';
import '../../../screens/utils/formz_email.dart';
import '../../../screens/utils/formz_list.dart';
import '../../../screens/utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class CreateCustomerBloc
    extends Bloc<CreateCustomerEvent, CreateCustomerState> {
  CustomerRepo customerRepo;
  CreateCustomerBloc(this.customerRepo) : super(const CreateCustomerState()) {
    on<CustCodeChanged>(_onCustCodeChanged);
    on<CustFirstNameChanged>(_onCustFirstNameChanged);
    on<CustLastNameChanged>(_onCustLastNameChanged);
    on<CustBranchChanged>(_onCustBranchChanged);
    on<CustContactNumberChanged>(_onCustContactNumberChanged);
    on<CustEmailChanged>(_onCustEmailChanged);
    on<CustCreditLimitChanged>(_onCustCreditLimitChanged);
    on<CustPaymentTermChanged>(_onCustPaymentTermChanged);
    on<CustAddressAdded>(_onCustAddressAdded);
    on<CustAddressRemoved>(_onCustAddressRemoved);
    on<NewCustomerSubmitted>(_onNewCustomerSubmitted);
  }

  void _onCustCodeChanged(
      CustCodeChanged event, Emitter<CreateCustomerState> emit) {
    final custCode = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custCode: custCode,
        status: Formz.validate([
          custCode,
          state.custPaymentTerm,
          state.custBranch,
          state.custPaymentTerm,
        ]),
      ),
    );
  }

  void _onCustFirstNameChanged(
      CustFirstNameChanged event, Emitter<CreateCustomerState> emit) {
    final custFirstName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custFirstName: custFirstName,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustLastNameChanged(
      CustLastNameChanged event, Emitter<CreateCustomerState> emit) {
    final custLastName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custLastName: custLastName,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustBranchChanged(
      CustBranchChanged event, Emitter<CreateCustomerState> emit) {
    final custBranch = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custBranch: custBranch,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          custBranch,
        ]),
      ),
    );
  }

  void _onCustContactNumberChanged(
      CustContactNumberChanged event, Emitter<CreateCustomerState> emit) {
    final custContactNumber = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custContactNumber: custContactNumber,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustEmailChanged(
      CustEmailChanged event, Emitter<CreateCustomerState> emit) {
    final custEmail = FormzEmail.dirty(event.value);

    emit(
      state.copyWith(
        custEmail: custEmail,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustCreditLimitChanged(
      CustCreditLimitChanged event, Emitter<CreateCustomerState> emit) {
    final custCreditLimit = FormzDouble.dirty(event.value);

    emit(
      state.copyWith(
        custCreditLimit: custCreditLimit,
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustPaymentTermChanged(
      CustPaymentTermChanged event, Emitter<CreateCustomerState> emit) {
    final custPaymentTerm = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custPaymentTerm: custPaymentTerm,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
          custPaymentTerm,
        ]),
      ),
    );
  }

  void _onCustAddressAdded(
      CustAddressAdded event, Emitter<CreateCustomerState> emit) {
    List<Map<String, dynamic>> addresses = [];
    if (event.value["is_default"]) {
      addresses.addAll(state.addresses.value.map((element) {
        element["is_default"] = false;
        return element;
      }).toList());
    } else {
      addresses.addAll(state.addresses.value);
    }
    addresses.add(event.value);

    emit(
      state.copyWith(
        addresses: FormzList.dirty(addresses),
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustAddressRemoved(
      CustAddressRemoved event, Emitter<CreateCustomerState> emit) {
    List<Map<String, dynamic>> addresses = [];

    addresses.addAll(state.addresses.value);
    addresses.removeAt(event.index);

    emit(
      state.copyWith(
        addresses: FormzList.dirty(addresses),
        status: Formz.validate([
          state.custCode,
          state.custPaymentTerm,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onNewCustomerSubmitted(
      NewCustomerSubmitted event, Emitter<CreateCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "customer_schema": {
        "code": state.custCode.value,
        "first_name": state.custFirstName.value,
        "last_name": state.custLastName.value,
        "contact_number": state.custContactNumber.value,
        if (state.custEmail.value.isNotEmpty) "email": state.custEmail.value,
        "location": state.custBranch.value,
        if (state.custPaymentTerm.value.isNotEmpty)
          "payment_term": state.custPaymentTerm.value,
        "credit_limit": state.custCreditLimit.value,
      },
      "addresses_schema": state.addresses.value,
    };

    try {
      String message = await customerRepo.create(data);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: message,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        ),
      );
    }
  }
}
