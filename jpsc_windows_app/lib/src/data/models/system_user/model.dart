import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
import 'base_model.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserModel extends SystemUserBaseModel {
  static List<AuthorizationModel>? _authFromJson(List<dynamic>? data) {
    if (data != null && data.isNotEmpty) {
      return data.map((e) => AuthorizationModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>>? _authToJson(
      List<AuthorizationModel>? rows) {
    if (rows != null && rows.isNotEmpty) {
      return rows.map((e) => e.toJson()).toList();
    }
    return [];
  }

  int id;

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel>? assignedBranch;

  @JsonKey(fromJson: _authFromJson, toJson: _authToJson)
  List<AuthorizationModel>? authorizations;

  @JsonKey(name: "item_group_auth")
  List<AuthItemGroupModel>? itemGroupAuth;

  SystemUserModel({
    required this.id,
    required super.email,
    super.firstName = '',
    super.lastName = '',
    super.positionCode,
    this.assignedBranch = const [],
    this.itemGroupAuth = const [],
    required super.isActive,
    required super.isSuperAdmin,
    required this.authorizations,
  });

  factory SystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserModelToJson(this);
}
