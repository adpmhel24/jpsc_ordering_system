// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCreateModel _$CustomerCreateModelFromJson(Map<String, dynamic> json) =>
    CustomerCreateModel(
      code: json['code'] as String,
      cardName: json['card_name'] as String?,
      location: json['location'] as String?,
      firstName: json['first_name'] as String?,
      middleInitial: json['middle_initial'] as String?,
      lastName: json['last_name'] as String?,
      creditLimit: (json['credit_limit'] as num?)?.toDouble(),
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      paymentTerm: json['payment_terms'] as String?,
    );

Map<String, dynamic> _$CustomerCreateModelToJson(
        CustomerCreateModel instance) =>
    <String, dynamic>{
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
    };
