// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerAddressModel _$CustomerAddressModelFromJson(
        Map<String, dynamic> json) =>
    CustomerAddressModel(
      uid: json['uid'] as String? ?? '',
      id: json['id'] as int?,
      streetAddress: json['street_address'] as String?,
      province: json['province'] as String?,
      cityMunicipality: json['city_municipality'] as String?,
      brgy: json['brgy'] as String?,
      otherDetails: json['other_details'] as String?,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble(),
      isDefault: json['is_default'] as bool?,
      isRemove: json['isRemove'] as bool? ?? false,
    );

Map<String, dynamic> _$CustomerAddressModelToJson(
    CustomerAddressModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', CustomerAddressModel.toNull(instance.uid));
  val['id'] = instance.id;
  val['street_address'] = instance.streetAddress;
  val['province'] = instance.province;
  val['city_municipality'] = instance.cityMunicipality;
  val['brgy'] = instance.brgy;
  val['other_details'] = instance.otherDetails;
  val['delivery_fee'] = instance.deliveryFee;
  val['is_default'] = instance.isDefault;
  val['isRemove'] = instance.isRemove;
  return val;
}
