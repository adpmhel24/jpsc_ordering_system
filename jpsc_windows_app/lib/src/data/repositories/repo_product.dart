import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class ProductRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.item;

  ProductRepo({
    required this.localStorage,
  });

  List<ProductModel> _datas = [];
  List<ProductModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: urlPath,
      params: params,
    );
    _datas = List<ProductModel>.from(
        response.data['data'].map((e) => ProductModel.fromJson(e))).toList();
  }

  Future<String> bulkInsert({required List<Map<String, dynamic>> datas}) async {
    Response response;

    response = await api.bulkInsert(
      _token,
      urlPath: "${urlPath}bulk_insert",
      datas: datas,
    );
    return response.data['message'];
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(
      _token,
      urlPath: urlPath,
      data: data,
    );

    return response.data['message'];
  }

  Future<String> update({
    required String fk,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    response = await api.update(
      _token,
      urlPath: "$urlPath$fk",
      data: data,
    );
    return response.data['message'];
  }

  Future<UomGroupModel?> getUomGroupAssigned(String itemCode) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }

    return _datas.firstWhere((element) => element.code == itemCode).uomGroup!;
  }

  Future<List<ProductModel>> offlineSearch(
      {String? keyword, String? itemGroupCode}) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if ((keyword != null && keyword.isNotEmpty) &&
        (itemGroupCode != null && itemGroupCode.isNotEmpty)) {
      var filtered = _datas
          .where(
            (item) =>
                item.code.toLowerCase().contains(
                      keyword.toLowerCase(),
                    ) &&
                item.itemGroup!.code.toLowerCase().contains(
                      itemGroupCode.toLowerCase(),
                    ),
          )
          .toList();
      return filtered;
    } else if (keyword != null &&
        keyword.isNotEmpty &&
        (itemGroupCode == null || itemGroupCode.isEmpty)) {
      var filtered = _datas
          .where(
            (item) => item.code.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    } else if (itemGroupCode != null &&
        itemGroupCode.isNotEmpty &&
        (keyword == null || keyword.isEmpty)) {
      var filtered = _datas
          .where(
            (item) => item.itemGroup!.code.toLowerCase().contains(
                  itemGroupCode.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }

  Future<List<ProductModel>> offlineSearchByKeyword(String keyword) async {
    if (_datas.isEmpty) {
      await getAll();
    }
    return _datas
        .where(
          (item) =>
              item.code.toLowerCase().contains(
                    keyword.toLowerCase(),
                  ) ||
              (item.description ?? "")
                  .toLowerCase()
                  .contains(keyword.toLowerCase()),
        )
        .toList();
  }
}
