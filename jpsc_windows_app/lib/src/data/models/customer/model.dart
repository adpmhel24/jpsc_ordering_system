import 'package:json_annotation/json_annotation.dart';
import '../models.dart';
import 'base_model.dart';

part 'model.g.dart';

@JsonSerializable()
class CustomerModel extends CustomerBaseModel {
  static List<CustomerAddressModel> customerAddressFromJson(
      List<dynamic> data) {
    if (data.isNotEmpty) {
      return data.map((e) => CustomerAddressModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>>? _rowsToJson(
      List<CustomerAddressModel> rows) {
    if (rows.isNotEmpty) {
      return rows.map((e) => e.toJson()).toList();
    }
    return [];
  }

  @JsonKey(name: "is_active")
  bool? isActive;

  @JsonKey(name: "is_approved")
  bool? isApproved;

  @JsonKey(name: "date_created")
  DateTime? dateCreated;

  @JsonKey(name: "created_by")
  int? createdBy;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  @JsonKey(name: "updated_by")
  int? updatedBy;

  @JsonKey(fromJson: customerAddressFromJson, toJson: _rowsToJson)
  List<CustomerAddressModel> addresses;

  CustomerModel({
    required super.code,
    super.cardName,
    super.firstName,
    super.middleInitial,
    super.lastName,
    super.contactNumber,
    super.email,
    this.isActive,
    super.location,
    super.paymentTerm,
    super.creditLimit,
    this.isApproved,
    this.createdBy,
    this.dateCreated,
    this.updatedBy,
    this.dateUpdated,
    this.addresses = const [],
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
