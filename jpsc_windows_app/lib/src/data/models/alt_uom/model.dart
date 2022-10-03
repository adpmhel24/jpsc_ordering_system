import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class AltUomModel {
  final int id;

  @JsonKey(name: "uom_group_code")
  final String uomGroupCode;

  @JsonKey(name: "alt_qty")
  final double altQty;

  @JsonKey(name: "alt_uom")
  final String altUom;

  @JsonKey(name: "base_qty")
  final double baseQty;

  @JsonKey(name: "base_uom")
  final String baseUom;

  AltUomModel({
    required this.id,
    required this.uomGroupCode,
    required this.altQty,
    required this.altUom,
    required this.baseQty,
    required this.baseUom,
  });

  factory AltUomModel.fromJson(Map<String, dynamic> json) =>
      _$AltUomModelFromJson(json);

  Map<String, dynamic> toJson() => _$AltUomModelToJson(this);
}
