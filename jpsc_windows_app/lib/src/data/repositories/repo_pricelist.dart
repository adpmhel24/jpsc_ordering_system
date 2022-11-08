import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class PricelistRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.pricelist;

  PricelistRepo({
    required this.localStorage,
  });

  List<PricelistModel> _datas = [];
  List<PricelistModel> get datas => _datas;

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
    _datas = List<PricelistModel>.from(
        response.data['data'].map((e) => PricelistModel.fromJson(e))).toList();
  }

  Future<PricelistModel> getByPricelistCode(String pricelistCode) async {
    Response response;

    response = await api.getByFk(_token, urlPath: urlPath, fk: pricelistCode);
    return PricelistModel.fromJson(response.data['data']);
  }

  Future<List<PricelistRowModel>> getByItemCode(String itemCode) async {
    Response response;

    response = await api.getByFk(_token,
        urlPath: "${urlPath}rows/by_item/", fk: itemCode);
    return List<PricelistRowModel>.from(
            response.data['data'].map((e) => PricelistRowModel.fromJson(e)))
        .toList();
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

  Future<List<PricelistRowLogModel>> getLogs(int pricelistRowId) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: "${urlPath}rows/logs/$pricelistRowId",
    );

    return List<PricelistRowLogModel>.from(
            response.data['data'].map((e) => PricelistRowLogModel.fromJson(e)))
        .toList();
  }

  Future<String> bulkUpdatePricelistRow({
    required List<Map<String, dynamic>> datas,
  }) async {
    Response response;

    response = await api.bulkUpdate(
      _token,
      urlPath: "${urlPath}rows/bulk_update",
      datas: datas,
    );
    return response.data['message'];
  }

  Future<List<PricelistModel>> offlineSearch(keyword) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    var filtered = _datas
        .where(
          (item) => item.code!.toLowerCase().contains(
                keyword!.toLowerCase(),
              ),
        )
        .toList();
    return filtered;
  }
}
