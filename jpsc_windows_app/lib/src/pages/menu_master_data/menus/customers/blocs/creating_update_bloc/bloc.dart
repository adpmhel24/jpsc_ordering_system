import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/utils/formz_bool.dart';
import 'package:jpsc_windows_app/src/utils/formz_double.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_email.dart';
import '../../../../../../utils/formz_list.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class CreateUpdateCustomerBloc
    extends Bloc<CreateUpdateCustomerEvent, CreateUpdateCustomerState> {
  CustomerRepo customerRepo;
  CustomerModel? selectedCustomer;
  CreateUpdateCustomerBloc({
    required this.customerRepo,
    this.selectedCustomer,
  }) : super(
          (selectedCustomer != null)
              ? CreateUpdateCustomerState(
                  custCode: FormzString.dirty(selectedCustomer.code),
                  cardName: FormzString.dirty(selectedCustomer.cardName ?? ""),
                  custFirstName:
                      FormzString.dirty(selectedCustomer.firstName ?? ""),
                  custLastName:
                      FormzString.dirty(selectedCustomer.lastName ?? ""),
                  custBranch:
                      FormzString.dirty(selectedCustomer.location ?? ""),
                  custContactNumber:
                      FormzString.dirty(selectedCustomer.contactNumber ?? ""),
                  custEmail: FormzEmail.dirty(selectedCustomer.email ?? ""),
                  custCreditLimit:
                      FormzDouble.dirty(selectedCustomer.creditLimit),
                  custPaymentTerm:
                      FormzString.dirty(selectedCustomer.paymentTerm ?? ""),
                  isActive: FormzBool.dirty(selectedCustomer.isActive),
                  isApproved: FormzBool.dirty(selectedCustomer.isApproved),
                  withSap: FormzBool.dirty(selectedCustomer.withSap),
                  addresses: FormzList.dirty(
                    selectedCustomer.addresses
                        .map((e) => CustomerAddressModel.fromJson(e.toJson()))
                        .toList(),
                  ),
                )
              : const CreateUpdateCustomerState(),
        ) {
    on<CustCodeChanged>(_onCustCodeChanged);
    on<CardnameChanged>(_onCardnameChanged);
    on<CustFirstNameChanged>(_onCustFirstNameChanged);
    on<CustLastNameChanged>(_onCustLastNameChanged);
    on<CustBranchChanged>(_onCustBranchChanged);
    on<CustContactNumberChanged>(_onCustContactNumberChanged);
    on<CustEmailChanged>(_onCustEmailChanged);
    on<CustCreditLimitChanged>(_onCustCreditLimitChanged);
    on<CustPaymentTermChanged>(_onCustPaymentTermChanged);
    on<CustIsActiveChanged>(_onCustIsActiveChanged);
    on<CustIsApprovedChanged>(_onCustIsApprovedChanged);
    on<CustWithSapChanged>(_onCustWithSapChanged);
    on<CustAddressAdded>(_onCustAddressAdded);
    on<CustAddressUpdated>(_onCustAddressUpdated);
    on<CustAddressRemoved>(_onCustAddressRemoved);
    on<NewCustomerSubmitted>(_onNewCustomerSubmitted);
    on<UpdateCustomerSubmitted>(_onUpdateCustomerSubmitted);
  }

  void _onCustCodeChanged(
      CustCodeChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custCode = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custCode: custCode,
        status: Formz.validate([
          custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCardnameChanged(
      CardnameChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final cardName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        cardName: cardName,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustFirstNameChanged(
      CustFirstNameChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custFirstName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custFirstName: custFirstName,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustLastNameChanged(
      CustLastNameChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custLastName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custLastName: custLastName,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustBranchChanged(
      CustBranchChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custBranch = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custBranch: custBranch,
        status: Formz.validate([
          state.custCode,
          custBranch,
        ]),
      ),
    );
  }

  void _onCustContactNumberChanged(
      CustContactNumberChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custContactNumber = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custContactNumber: custContactNumber,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustEmailChanged(
      CustEmailChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custEmail = FormzEmail.dirty(event.value);

    emit(
      state.copyWith(
        custEmail: custEmail,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustCreditLimitChanged(
      CustCreditLimitChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custCreditLimit = FormzDouble.dirty(event.value);

    emit(
      state.copyWith(
        custCreditLimit: custCreditLimit,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustPaymentTermChanged(
      CustPaymentTermChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final custPaymentTerm = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        custPaymentTerm: custPaymentTerm,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustIsActiveChanged(
      CustIsActiveChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final isActive = FormzBool.dirty(event.value);

    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustIsApprovedChanged(
      CustIsApprovedChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final isApproved = FormzBool.dirty(event.value);

    emit(
      state.copyWith(
        isApproved: isApproved,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustWithSapChanged(
      CustWithSapChanged event, Emitter<CreateUpdateCustomerState> emit) {
    final withSap = FormzBool.dirty(event.value);

    emit(
      state.copyWith(
        withSap: withSap,
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustAddressAdded(
      CustAddressAdded event, Emitter<CreateUpdateCustomerState> emit) {
    List<CustomerAddressModel> addresses = [];
    if (event.value.isDefault!) {
      addresses.addAll(state.addresses.value.map((element) {
        element.isDefault = false;
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
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustAddressRemoved(
      CustAddressRemoved event, Emitter<CreateUpdateCustomerState> emit) {
    List<CustomerAddressModel> addresses = [];

    addresses.addAll(state.addresses.value);

    addresses[event.index].isRemove = true;

    emit(
      state.copyWith(
        addresses: FormzList.dirty(addresses),
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onCustAddressUpdated(
      CustAddressUpdated event, Emitter<CreateUpdateCustomerState> emit) {
    List<CustomerAddressModel> addresses = [];

    if (event.value.isDefault!) {
      addresses.addAll(state.addresses.value.map((element) {
        element.isDefault = false;
        return element;
      }).toList());
    } else {
      addresses.addAll(state.addresses.value);
    }
    addresses[event.index] = event.value;

    emit(
      state.copyWith(
        addresses: FormzList.dirty(addresses),
        status: Formz.validate([
          state.custCode,
          state.custBranch,
        ]),
      ),
    );
  }

  void _onNewCustomerSubmitted(NewCustomerSubmitted event,
      Emitter<CreateUpdateCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "customer_schema": {
        "code": state.custCode.value,
        "card_name": state.cardName.value,
        "first_name": state.custFirstName.value,
        "last_name": state.custLastName.value,
        "contact_number": state.custContactNumber.value,
        if (state.custEmail.valid) "email": state.custEmail.value,
        "credit_limit": state.custCreditLimit.value,
        "location": state.custBranch.value,
        "payment_terms": state.custPaymentTerm.value,
        "is_active": state.isActive.value,
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

  void _onUpdateCustomerSubmitted(UpdateCustomerSubmitted event,
      Emitter<CreateUpdateCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "customer_schema": {
        "code": state.custCode.value,
        "card_name": state.cardName.value,
        "first_name": state.custFirstName.value,
        "last_name": state.custLastName.value,
        "contact_number": state.custContactNumber.value,
        if (state.custEmail.valid) "email": state.custEmail.value,
        "credit_limit": state.custCreditLimit.value,
        "location": state.custBranch.value,
        if (state.custPaymentTerm.value.isNotEmpty)
          "payment_terms": state.custPaymentTerm.value,
        "is_active": state.isActive.value,
        "is_approved": state.isApproved.value,
        "with_sap": state.withSap.value,
      },
      "addresses_schema": state.addresses.value.map((e) => e.toJson()).toList(),
    };

    try {
      String message = await customerRepo.update(
          customerCode: selectedCustomer!.code, data: data);
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
