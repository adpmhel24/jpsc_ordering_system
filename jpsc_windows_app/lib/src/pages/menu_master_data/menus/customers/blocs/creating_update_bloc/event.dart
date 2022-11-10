part of 'bloc.dart';

abstract class CreateUpdateCustomerEvent extends Equatable {
  const CreateUpdateCustomerEvent();
  @override
  List<Object?> get props => [];
}

class CustomerSelected extends CreateUpdateCustomerEvent {
  final CustomerModel selectedCustomer;

  const CustomerSelected(this.selectedCustomer);

  @override
  List<Object?> get props => [selectedCustomer];
}

class CustCodeChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustCodeChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CardnameChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CardnameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustFirstNameChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustFirstNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustLastNameChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustLastNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustBranchChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustBranchChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustContactNumberChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustContactNumberChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustEmailChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustEmailChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustCreditLimitChanged extends CreateUpdateCustomerEvent {
  final double value;
  const CustCreditLimitChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustPaymentTermChanged extends CreateUpdateCustomerEvent {
  final String value;
  const CustPaymentTermChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustIsActiveChanged extends CreateUpdateCustomerEvent {
  final bool value;
  const CustIsActiveChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustWithSapChanged extends CreateUpdateCustomerEvent {
  final bool value;
  const CustWithSapChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustIsApprovedChanged extends CreateUpdateCustomerEvent {
  final bool value;
  const CustIsApprovedChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustAddressAdded extends CreateUpdateCustomerEvent {
  final CustomerAddressModel value;

  const CustAddressAdded(this.value);

  @override
  List<Object?> get props => [value];
}

class CustAddressRemoved extends CreateUpdateCustomerEvent {
  final int index;

  const CustAddressRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class CustAddressUpdated extends CreateUpdateCustomerEvent {
  final int index;
  final CustomerAddressModel value;

  const CustAddressUpdated(this.index, this.value);

  @override
  List<Object?> get props => [index, value];
}

class NewCustomerSubmitted extends CreateUpdateCustomerEvent {}

class UpdateCustomerSubmitted extends CreateUpdateCustomerEvent {}
