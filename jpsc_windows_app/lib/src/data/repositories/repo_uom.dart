import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class UomRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.uom;

  UomRepo({
    required this.localStorage,
  });

  List<UomModel> _datas = [];
  List<UomModel> get datas => _datas;

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
    _datas = List<UomModel>.from(
        response.data['data'].map((e) => UomModel.fromJson(e))).toList();
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

  Future<List<UomModel>> offlineSearch(String value) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (value.isNotEmpty) {
      var filtered = _datas
          .where(
            (whse) => whse.code.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
