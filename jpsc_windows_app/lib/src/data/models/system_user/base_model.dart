import 'package:json_annotation/json_annotation.dart';

abstract class SystemUserBaseModel {
  String email;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "is_super_admin")
  bool isSuperAdmin;

  @JsonKey(name: "position_code")
  String? positionCode;

  SystemUserBaseModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.isSuperAdmin,
    this.positionCode,
  });
}
