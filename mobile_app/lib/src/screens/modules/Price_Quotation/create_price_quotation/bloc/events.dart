part of 'bloc.dart';

abstract class CreateSalesOrderEvent extends Equatable {
  const CreateSalesOrderEvent();
  @override
  List<Object?> get props => [];
}

class BranchCodeChanged extends CreateSalesOrderEvent {
  final String branchCode;

  const BranchCodeChanged(this.branchCode);

  @override
  List<Object?> get props => [branchCode];
}

class CustomerChanged extends CreateSalesOrderEvent {
  final CustomerModel? customer;
  const CustomerChanged(this.customer);

  @override
  List<Object?> get props => [customer];
}

class DeliveryDateChanged extends CreateSalesOrderEvent {
  final String deliveryDate;
  const DeliveryDateChanged(this.deliveryDate);
  @override
  List<Object?> get props => [deliveryDate];
}

class DeliveryMethodChanged extends CreateSalesOrderEvent {
  final String deliveryMethod;
  const DeliveryMethodChanged(this.deliveryMethod);
  @override
  List<Object?> get props => [deliveryMethod];
}

class PaymentTermChanged extends CreateSalesOrderEvent {
  final String paymentMethod;
  const PaymentTermChanged(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}

class RemarksChanged extends CreateSalesOrderEvent {
  final String remarks;
  const RemarksChanged(this.remarks);
  @override
  List<Object?> get props => [remarks];
}

class ContactNumberChanged extends CreateSalesOrderEvent {
  final String contactNumber;
  const ContactNumberChanged(this.contactNumber);
  @override
  List<Object?> get props => [contactNumber];
}

class AddressChanged extends CreateSalesOrderEvent {
  final String address;
  const AddressChanged(this.address);
  @override
  List<Object?> get props => [address];
}

class CartItemAdded extends CreateSalesOrderEvent {
  final CartItemModel cartItem;
  const CartItemAdded(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class CartItemDeleted extends CreateSalesOrderEvent {
  final CartItemModel cartItem;
  const CartItemDeleted(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class ClearSalesOrder extends CreateSalesOrderEvent {}

class OrderSubmitted extends CreateSalesOrderEvent {
  final String hashedId;
  const OrderSubmitted(this.hashedId);
  @override
  List<Object?> get props => [hashedId];
}
