part of 'bloc.dart';

class CreateUpdateCustomerState extends Equatable {
  final FormzStatus status;
  final FormzString custCode;
  final FormzString cardName;
  final FormzString custFirstName;
  final FormzString custLastName;
  final FormzString custBranch;
  final FormzString custContactNumber;
  final FormzEmail custEmail;
  final FormzDouble custCreditLimit;
  final FormzString custPaymentTerm;
  final FormzList<CustomerAddressModel> addresses;
  final FormzBool isActive;
  final FormzBool isApproved;
  final String message;

  const CreateUpdateCustomerState({
    this.status = FormzStatus.pure,
    this.custCode = const FormzString.pure(),
    this.cardName = const FormzString.pure(),
    this.custFirstName = const FormzString.pure(),
    this.custLastName = const FormzString.pure(),
    this.custBranch = const FormzString.pure(),
    this.custContactNumber = const FormzString.pure(),
    this.custEmail = const FormzEmail.pure(),
    this.custCreditLimit = const FormzDouble.pure(),
    this.custPaymentTerm = const FormzString.pure(),
    this.addresses = const FormzList.pure(),
    this.isActive = const FormzBool.dirty(true),
    this.isApproved = const FormzBool.dirty(false),
    this.message = "",
  });

  CreateUpdateCustomerState copyWith({
    FormzStatus? status,
    FormzString? custCode,
    FormzString? cardName,
    FormzString? custFirstName,
    FormzString? custLastName,
    FormzString? custBranch,
    FormzString? custContactNumber,
    FormzEmail? custEmail,
    FormzDouble? custCreditLimit,
    FormzString? custPaymentTerm,
    FormzBool? isActive,
    FormzBool? isApproved,
    FormzList<CustomerAddressModel>? addresses,
    String? message,
  }) =>
      CreateUpdateCustomerState(
        status: status ?? this.status,
        custCode: custCode ?? this.custCode,
        cardName: cardName ?? this.cardName,
        custFirstName: custFirstName ?? this.custFirstName,
        custLastName: custLastName ?? this.custLastName,
        custBranch: custBranch ?? this.custBranch,
        custContactNumber: custContactNumber ?? this.custContactNumber,
        custEmail: custEmail ?? this.custEmail,
        custCreditLimit: custCreditLimit ?? this.custCreditLimit,
        custPaymentTerm: custPaymentTerm ?? this.custPaymentTerm,
        addresses: addresses ?? this.addresses,
        isActive: isActive ?? this.isActive,
        isApproved: isApproved ?? this.isApproved,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        custCode,
        cardName,
        custFirstName,
        custLastName,
        custBranch,
        custContactNumber,
        custEmail,
        custCreditLimit,
        custPaymentTerm,
        isActive,
        isApproved,
        addresses,
        message,
      ];
}
