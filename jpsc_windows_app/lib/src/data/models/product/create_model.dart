import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'create_model.g.dart';

@JsonSerializable()
class CreateProductModel extends ProductBaseModel {
  CreateProductModel({
    required super.code,
    super.description,
    super.itemGroupCode,
    super.saleUomCode,
    super.barcode,
  });

  factory CreateProductModel.fromJson(Map<String, dynamic> json) =>
      _$CreateProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductModelToJson(this);
}
