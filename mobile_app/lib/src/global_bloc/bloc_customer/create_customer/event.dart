part of 'bloc.dart';

abstract class CreateCustomerEvent extends Equatable {
  const CreateCustomerEvent();
  @override
  List<Object?> get props => [];
}

class CustCodeChanged extends CreateCustomerEvent {
  final String value;
  const CustCodeChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustFirstNameChanged extends CreateCustomerEvent {
  final String value;
  const CustFirstNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustLastNameChanged extends CreateCustomerEvent {
  final String value;
  const CustLastNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustBranchChanged extends CreateCustomerEvent {
  final String value;
  const CustBranchChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustContactNumberChanged extends CreateCustomerEvent {
  final String value;
  const CustContactNumberChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustEmailChanged extends CreateCustomerEvent {
  final String value;
  const CustEmailChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustPaymentTermChanged extends CreateCustomerEvent {
  final String value;
  const CustPaymentTermChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CustAddressAdded extends CreateCustomerEvent {
  final Map<String, dynamic> value;

  const CustAddressAdded(this.value);

  @override
  List<Object?> get props => [value];
}

class CustAddressRemoved extends CreateCustomerEvent {
  final int index;

  const CustAddressRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class NewCustomerSubmitted extends CreateCustomerEvent {}
