import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_model.dart';

part 'create_model.g.dart';

@JsonSerializable()
class CustomerCreateModel extends CustomerBaseModel {
  CustomerCreateModel({
    required super.code,
    super.cardName,
    super.location,
    super.firstName,
    super.middleInitial,
    super.lastName,
    super.creditLimit,
    super.contactNumber,
    super.email,
    super.paymentTerm,
  });

  factory CustomerCreateModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerCreateModelToJson(this);
}
