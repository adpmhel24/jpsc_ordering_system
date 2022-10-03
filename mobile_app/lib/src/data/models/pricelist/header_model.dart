import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/src/data/models/pricelist/row_model.dart';

part 'header_model.g.dart';

@JsonSerializable()
class PricelistHeaderModel {
  String code;

  String description;

  @JsonKey(name: "is_active")
  bool isActive;

  List<PricelistRowModel> rows;

  PricelistHeaderModel({
    required this.code,
    required this.description,
    required this.isActive,
    required this.rows,
  });

  factory PricelistHeaderModel.fromJson(Map<String, dynamic> json) =>
      _$PricelistHeaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistHeaderModelToJson(this);
}
