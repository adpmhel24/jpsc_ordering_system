import 'package:freezed_annotation/freezed_annotation.dart';

import 'row_model.dart';

part 'model.g.dart';

@JsonSerializable()
class PricelistModel {
  String? code;
  String? description;
  @JsonKey(name: "is_active")
  bool? isActive;
  List<PricelistRowModel>? rows;

  PricelistModel({this.code, this.description, this.isActive, this.rows});
  factory PricelistModel.fromJson(Map<String, dynamic> json) =>
      _$PricelistModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistModelToJson(this);
}
