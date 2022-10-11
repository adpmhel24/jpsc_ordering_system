// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      code: json['code'] as String,
      fullName: json['full_name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool?,
      location: json['location'] as String?,
      isApproved: json['is_approved'] as bool?,
      createdBy: json['created_by'] as int?,
      dateCreated: json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      updatedBy: json['updated_by'] as int?,
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      addresses:
          CustomerModel.customerAddressFromJson(json['addresses'] as List),
    )..paymentTerms = json['payment_terms'] as String?;

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'full_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'contact_number': instance.contactNumber,
      'email': instance.email,
      'is_active': instance.isActive,
      'location': instance.location,
      'payment_terms': instance.paymentTerms,
      'is_approved': instance.isApproved,
      'date_created': instance.dateCreated?.toIso8601String(),
      'created_by': instance.createdBy,
      'date_updated': instance.dateUpdated?.toIso8601String(),
      'updated_by': instance.updatedBy,
      'addresses': CustomerModel._rowsToJson(instance.addresses),
    };
