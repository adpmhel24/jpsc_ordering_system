import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_model.dart';

part 'create_model.g.dart';

@JsonSerializable()
class CreateSystemUserModel extends SystemUserBaseModel {
  String password;
  CreateSystemUserModel({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.isActive,
    required super.isSuperAdmin,
    super.positionCode,
    required this.password,
  });

  factory CreateSystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$CreateSystemUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSystemUserModelToJson(this);
}
