import 'package:json_annotation/json_annotation.dart';

abstract class CustomerBaseModel {
  String code;

  @JsonKey(name: "card_name")
  String? cardName;

  String? location;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "middle_initial")
  String? middleInitial;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  String? email;

  @JsonKey(name: "payment_terms")
  String? paymentTerm;

  @JsonKey(name: "credit_limit")
  double? creditLimit;

  CustomerBaseModel({
    required this.code,
    this.cardName,
    this.location,
    this.firstName,
    this.middleInitial,
    this.lastName,
    this.contactNumber,
    this.email,
    this.paymentTerm,
    this.creditLimit,
  });
}
