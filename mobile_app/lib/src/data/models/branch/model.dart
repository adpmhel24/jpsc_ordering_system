import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class BranchModel {
  String code;
  String? description;

  @JsonKey(name: "is_active")
  bool isActive;

  BranchModel({
    required this.code,
    this.description,
    required this.isActive,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
