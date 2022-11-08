import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class CustomerModel {
  static List<CustomerAddressModel?> customerAddressFromJson(
      List<dynamic> data) {
    if (data.isNotEmpty) {
      return data.map((e) => CustomerAddressModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>>? _rowsToJson(
      List<CustomerAddressModel?> rows) {
    if (rows.isNotEmpty) {
      return rows.map((e) => e!.toJson()).toList();
    }
    return [];
  }

  String code;

  @JsonKey(name: "card_name")
  String? cardName;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  String? email;

  @JsonKey(name: "is_active")
  bool? isActive;

  String? location;

  @JsonKey(name: "payment_terms")
  String? paymentTerms;

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
  List<CustomerAddressModel?> addresses;

  CustomerModel({
    required this.code,
    this.cardName,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.email,
    this.isActive,
    this.location,
    this.paymentTerms,
    this.isApproved,
    this.createdBy,
    this.dateCreated,
    this.updatedBy,
    this.dateUpdated,
    required this.addresses,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
