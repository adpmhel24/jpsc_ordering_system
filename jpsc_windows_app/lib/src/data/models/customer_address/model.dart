import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class CustomerAddressModel {
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  String? uid;

  int? id;

  @JsonKey(name: "street_address")
  String? streetAddress;

  String? province;

  @JsonKey(name: "city_municipality")
  String? cityMunicipality;

  String? brgy;

  @JsonKey(name: "other_details")
  String? otherDetails;

  @JsonKey(name: "delivery_fee")
  double? deliveryFee;

  @JsonKey(name: "is_default")
  bool? isDefault;

  bool isRemove;

  CustomerAddressModel({
    this.uid = '',
    this.id,
    this.streetAddress,
    this.province,
    this.cityMunicipality,
    this.brgy,
    this.otherDetails,
    this.deliveryFee,
    this.isDefault,
    this.isRemove = false,
  });

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAddressModelToJson(this);
}
