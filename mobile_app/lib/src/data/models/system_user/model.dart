import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserModel {
  int id;
  String email;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "is_active")
  bool isActive;

  @JsonKey(name: "position_code")
  String? positionCode;

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel> assignedBranch;

  SystemUserModel({
    required this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.positionCode,
    this.assignedBranch = const [],
    required this.isActive,
  });

  factory SystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserModelToJson(this);
}
