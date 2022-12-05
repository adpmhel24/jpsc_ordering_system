// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      code: json['code'] as String,
      cardName: json['card_name'] as String?,
      firstName: json['first_name'] as String?,
      middleInitial: json['middle_initial'] as String?,
      lastName: json['last_name'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool?,
      location: json['location'] as String?,
      paymentTerm: json['payment_terms'] as String?,
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      isApproved: json['is_approved'] as bool?,
      createdBy: json['created_by'] as int?,
      dateCreated: json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      updatedBy: json['updated_by'] as int?,
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      addresses: json['addresses'] == null
          ? const []
          : CustomerModel.customerAddressFromJson(json['addresses'] as List),
    )
      ..withSap = json['with_sap'] as bool?
      ..createdByUser = json['created_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['created_by_user'] as Map<String, dynamic>);

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'card_name': instance.cardName,
    'location': instance.location,
    'first_name': instance.firstName,
    'middle_initial': instance.middleInitial,
    'last_name': instance.lastName,
    'contact_number': instance.contactNumber,
    'email': instance.email,
    'payment_terms': instance.paymentTerm,
    'credit_limit': instance.creditLimit,
    'is_active': instance.isActive,
    'is_approved': instance.isApproved,
    'with_sap': instance.withSap,
    'date_created': instance.dateCreated?.toIso8601String(),
    'created_by': instance.createdBy,
    'date_updated': instance.dateUpdated?.toIso8601String(),
    'updated_by': instance.updatedBy,
    'addresses': CustomerModel._rowsToJson(instance.addresses),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('created_by_user', CustomerModel.toNull(instance.createdByUser));
  return val;
}
