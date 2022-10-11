import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PaymentTermsModel {
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

  PaymentTermsModel(
      {required this.code,
      this.description,
      this.createdBy,
      this.dateCreated,
      this.dateUpdated,
      this.updatedBy});

  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTermsModelToJson(this);
}
