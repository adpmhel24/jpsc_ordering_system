import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class UomGroupModel {
  final String code;

  final String description;

  @JsonKey(name: "base_qty")
  final double baseQty;

  @JsonKey(name: "base_uom")
  final String baseUom;

  @JsonKey(name: "is_active")
  final bool isActive;

  UomGroupModel({
    required this.code,
    required this.description,
    required this.baseQty,
    required this.baseUom,
    required this.isActive,
  });

  factory UomGroupModel.fromJson(Map<String, dynamic> json) =>
      _$UomGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomGroupModelToJson(this);
}
