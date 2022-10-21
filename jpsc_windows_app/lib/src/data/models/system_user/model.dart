import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserModel {
  static List<AuthorizationModel> _authFromJson(List<dynamic> data) {
    if (data.isNotEmpty) {
      return data.map((e) => AuthorizationModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>>? _authToJson(
      List<AuthorizationModel> rows) {
    if (rows.isNotEmpty) {
      return rows.map((e) => e.toJson()).toList();
    }
    return [];
  }

  int id;
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

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel> assignedBranch;

  @JsonKey(fromJson: _authFromJson, toJson: _authToJson)
  List<AuthorizationModel> authorizations;

  SystemUserModel({
    required this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.positionCode,
    this.assignedBranch = const [],
    required this.isActive,
    required this.isSuperAdmin,
    required this.authorizations,
  });

  factory SystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserModelToJson(this);
}
