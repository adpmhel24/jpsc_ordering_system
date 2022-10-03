class PricelistModel {
  String? code;
  String? description;
  bool? isActive;
  List<PricelistRowModel>? rows;

  PricelistModel({this.code, this.description, this.isActive, this.rows});

  PricelistModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    isActive = json['is_active'];
    if (json['rows'] != null) {
      rows = <PricelistRowModel>[];
      json['rows'].forEach((v) {
        rows!.add(PricelistRowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['description'] = description;
    data['is_active'] = isActive;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PricelistRowModel {
  String? pricelistCode;
  String? itemCode;
  double? price;
  String? uomCode;
  int? id;

  PricelistRowModel(
      {this.pricelistCode, this.itemCode, this.price, this.uomCode, this.id});

  PricelistRowModel.fromJson(Map<String, dynamic> json) {
    pricelistCode = json['pricelist_code'];
    itemCode = json['item_code'];
    price = json['price'];
    uomCode = json['uom_code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pricelist_code'] = pricelistCode;
    data['item_code'] = itemCode;
    data['price'] = price;
    data['uom_code'] = uomCode;
    data['id'] = id;
    return data;
  }
}
