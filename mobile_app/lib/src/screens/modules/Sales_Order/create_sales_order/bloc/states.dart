part of 'bloc.dart';

class CreateSalesOrderState extends Equatable {
  final FormzStatus status;
  final FormzString customerCode;
  final FormzString deliveryDate;
  final FormzString deliveryMethod;
  final FormzString paymentTerm;
  final FormzString address;
  final FormzString contactNumber;
  final FormzString dispatchingBranch;
  final FormzString remarks;
  final String message;

  // final List<CartItemModel> cartItems;
  final FormzList<CartItemModel> cartItems;

  const CreateSalesOrderState({
    this.status = FormzStatus.pure,
    this.customerCode = const FormzString.pure(),
    this.deliveryDate = const FormzString.pure(),
    this.deliveryMethod = const FormzString.pure(),
    this.paymentTerm = const FormzString.pure(),
    this.address = const FormzString.pure(),
    this.contactNumber = const FormzString.pure(),
    this.dispatchingBranch = const FormzString.pure(),
    this.remarks = const FormzString.pure(),
    this.cartItems = const FormzList.pure(),
    this.message = "",
  });

  CreateSalesOrderState copyWith({
    FormzStatus? status,
    FormzString? customerCode,
    FormzString? deliveryDate,
    FormzString? deliveryMethod,
    FormzString? paymentTerm,
    FormzString? address,
    FormzString? contactNumber,
    FormzString? dispatchingBranch,
    FormzString? remarks,
    FormzList<CartItemModel>? cartItems,
    String? message,
  }) {
    return CreateSalesOrderState(
        status: status ?? this.status,
        customerCode: customerCode ?? this.customerCode,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryMethod: deliveryMethod ?? this.deliveryMethod,
        paymentTerm: paymentTerm ?? this.paymentTerm,
        address: address ?? this.address,
        contactNumber: contactNumber ?? this.contactNumber,
        dispatchingBranch: dispatchingBranch ?? this.dispatchingBranch,
        remarks: remarks ?? this.remarks,
        cartItems: cartItems ?? this.cartItems,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        status,
        customerCode,
        deliveryDate,
        deliveryMethod,
        paymentTerm,
        address,
        contactNumber,
        dispatchingBranch,
        remarks,
        cartItems,
        message
      ];
}
