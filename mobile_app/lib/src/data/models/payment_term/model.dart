import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PaymentTermModel {
  String code;

  String? description;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  @JsonKey(name: "updated_by")
  int? updatedBy;

  @JsonKey(name: "date_created")
  DateTime? dateCreated;

  @JsonKey(name: "created_by")
  int? createdBy;

  PaymentTermModel(
      {required this.code,
      this.description,
      this.createdBy,
      this.dateCreated,
      this.dateUpdated,
      this.updatedBy});

  factory PaymentTermModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermModelToJson(this);
}
