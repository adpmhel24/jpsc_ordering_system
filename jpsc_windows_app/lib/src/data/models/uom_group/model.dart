import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

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

  @JsonKey(name: "alt_uoms")
  final List<AltUomModel>? altUoms;

  UomGroupModel({
    required this.code,
    required this.description,
    required this.baseQty,
    required this.baseUom,
    required this.isActive,
    this.altUoms = const [],
  });

  factory UomGroupModel.fromJson(Map<String, dynamic> json) =>
      _$UomGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomGroupModelToJson(this);
}
