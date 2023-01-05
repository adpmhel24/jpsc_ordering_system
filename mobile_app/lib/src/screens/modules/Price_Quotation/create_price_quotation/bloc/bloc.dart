import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../utils/formz_list.dart';
import '../../../../utils/formz_string.dart';

part 'events.dart';
part 'states.dart';

class CreatePriceQuotationBloc
    extends Bloc<CreateSalesOrderEvent, CreateSalesOrderState> {
  final PriceQuotationRepo _salesOrderRepo;
  CreatePriceQuotationBloc(this._salesOrderRepo)
      : super(const CreateSalesOrderState()) {
    on<CustomerChanged>(_onCustomerChanged);
    on<BranchCodeChanged>(_onBranchCodeChanged);
    on<DeliveryDateChanged>(_onDeliveryDateChanged);
    on<DeliveryMethodChanged>(_onDeliveryMethodChanged);
    on<PaymentTermChanged>(_onPaymentTermChanged);
    on<ContactNumberChanged>(_onContactNumberChanged);
    on<AddressChanged>(_onAddressChanged);
    on<RemarksChanged>(_onRemarksChanged);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemDeleted>(_onCartItemDeleted);
    on<ClearSalesOrder>(_onClearSalesOrder);
    on<OrderSubmitted>(_onOrderSubmitted);
  }

  void _onCustomerChanged(
      CustomerChanged event, Emitter<CreateSalesOrderState> emit) {
    final customerCode = FormzString.dirty(event.customer?.code ?? "");
    final contactNumber = FormzString.dirty(
      event.customer?.contactNumber ?? "",
    );
    final paymentTerm = FormzString.dirty(
      event.customer?.paymentTerms ?? "",
    );

    emit(
      state.copyWith(
        customerCode: customerCode,
        contactNumber: contactNumber,
        paymentTerm: paymentTerm,
        status: Formz.validate(
          [
            customerCode,
            state.deliveryDate,
            state.deliveryMethod,
            state.dispatchingBranch,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onBranchCodeChanged(
      BranchCodeChanged event, Emitter<CreateSalesOrderState> emit) {
    final dispatchingBranch = FormzString.dirty(event.branchCode);

    emit(
      state.copyWith(
        dispatchingBranch: dispatchingBranch,
        status: Formz.validate(
          [
            dispatchingBranch,
            state.customerCode,
            state.deliveryDate,
            state.deliveryMethod,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onDeliveryDateChanged(
      DeliveryDateChanged event, Emitter<CreateSalesOrderState> emit) {
    final deliveryDate = FormzString.dirty(event.deliveryDate);

    emit(
      state.copyWith(
        deliveryDate: deliveryDate,
        status: Formz.validate(
          [
            deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.deliveryMethod,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onDeliveryMethodChanged(
      DeliveryMethodChanged event, Emitter<CreateSalesOrderState> emit) {
    final deliveryMethod = FormzString.dirty(event.deliveryMethod);

    emit(
      state.copyWith(
        deliveryMethod: deliveryMethod,
        status: Formz.validate(
          [
            deliveryMethod,
            state.deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onPaymentTermChanged(
      PaymentTermChanged event, Emitter<CreateSalesOrderState> emit) {
    final paymentTerm = FormzString.dirty(event.paymentMethod);

    emit(
      state.copyWith(
        paymentTerm: paymentTerm,
        status: Formz.validate(
          [
            paymentTerm,
            state.deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onContactNumberChanged(
      ContactNumberChanged event, Emitter<CreateSalesOrderState> emit) {
    final contactNumber = FormzString.dirty(event.contactNumber);

    emit(
      state.copyWith(
        contactNumber: contactNumber,
        status: Formz.validate(
          [
            state.deliveryMethod,
            state.deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onAddressChanged(
      AddressChanged event, Emitter<CreateSalesOrderState> emit) {
    final address = FormzString.dirty(event.address);

    emit(
      state.copyWith(
        address: address,
        status: Formz.validate(
          [
            state.deliveryMethod,
            state.deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onRemarksChanged(
      RemarksChanged event, Emitter<CreateSalesOrderState> emit) {
    final remarks = FormzString.dirty(event.remarks);

    emit(
      state.copyWith(
        remarks: remarks,
        status: Formz.validate(
          [
            state.deliveryMethod,
            state.deliveryDate,
            state.dispatchingBranch,
            state.customerCode,
            state.cartItems,
          ],
        ),
      ),
    );
  }

  void _onCartItemAdded(
      CartItemAdded event, Emitter<CreateSalesOrderState> emit) {
    FormzList<CartItemModel> formzCartItems;
    List<CartItemModel> cartItems = [];

    if (state.cartItems.valid) {
      cartItems = [...state.cartItems.value];

      // Get the index it the itemCode was already added to the list
      int index = cartItems.indexWhere((item) =>
          item.itemCode == event.cartItem.itemCode &&
          item.unitPrice == event.cartItem.unitPrice);

      // if the index is ge of 0 then replace the current index else add to the list.
      if (index >= 0) {
        cartItems[index] = event.cartItem;
      } else {
        cartItems.add(event.cartItem);
      }
    } else {
      cartItems.add(event.cartItem);
    }

    formzCartItems = FormzList<CartItemModel>.dirty(cartItems);

    emit(
      state.copyWith(
        cartItems: formzCartItems,
        status: Formz.validate(
          [
            formzCartItems,
            state.dispatchingBranch,
            state.customerCode,
            state.deliveryDate,
            state.deliveryMethod,
          ],
        ),
      ),
    );
  }

  void _onCartItemDeleted(
      CartItemDeleted event, Emitter<CreateSalesOrderState> emit) {
    FormzList<CartItemModel> formzCartItems;
    List<CartItemModel> cartItems = [];

    if (state.cartItems.valid) {
      cartItems = [...state.cartItems.value];
      cartItems.remove(event.cartItem);
    }

    formzCartItems = FormzList<CartItemModel>.dirty(cartItems);

    emit(
      state.copyWith(
        cartItems: formzCartItems,
        status: Formz.validate(
          [
            formzCartItems,
            state.dispatchingBranch,
            state.customerCode,
            state.deliveryDate,
            state.deliveryMethod,
          ],
        ),
      ),
    );
  }

  void _onClearSalesOrder(
      ClearSalesOrder event, Emitter<CreateSalesOrderState> emit) {
    emit(state.copyWith(
      status: FormzStatus.pure,
      customerCode: const FormzString.pure(),
      deliveryDate: const FormzString.pure(),
      deliveryMethod: const FormzString.pure(),
      paymentTerm: const FormzString.pure(),
      address: const FormzString.pure(),
      contactNumber: const FormzString.pure(),
      dispatchingBranch: const FormzString.pure(),
      remarks: const FormzString.pure(),
      cartItems: const FormzList<CartItemModel>.pure(),
    ));
  }

  void _onOrderSubmitted(
      OrderSubmitted event, Emitter<CreateSalesOrderState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "header_schema": {
        "transdate": DateTime.now().toIso8601String(),
        "customer_code": state.customerCode.value,
        "delivery_date": state.deliveryDate.value,
        "delivery_method": state.deliveryMethod.value,
        "payment_terms":
            state.paymentTerm.value.isEmpty ? null : state.paymentTerm.value,
        "remarks": state.remarks.value,
        "dispatching_branch": state.dispatchingBranch.value,
        "hashed_id": event.hashedId,
        "contact_number": state.contactNumber.value,
        "address": state.address.value,
        "customer_notes": null,
      },
      "rows_schema": state.cartItems.value.map((e) => e.toJson()).toList(),
    };
    try {
      String message = await _salesOrderRepo.create(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}
