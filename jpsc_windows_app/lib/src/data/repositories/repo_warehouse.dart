import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class WarehouseRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.branch;

  WarehouseRepo({
    required this.localStorage,
  });

  List<WarehouseModel> _datas = [];
  List<WarehouseModel> get datas => _datas;

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
    _datas = List<WarehouseModel>.from(
        response.data['data'].map((e) => WarehouseModel.fromJson(e))).toList();
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

  Future<List<WarehouseModel>> offlineSearch(
      {String? keyword, String? branchCode}) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (keyword != null &&
        keyword.isNotEmpty &&
        branchCode != null &&
        branchCode.isNotEmpty) {
      var filtered = _datas
          .where(
            (whse) =>
                whse.code.toLowerCase().contains(
                      keyword.toLowerCase(),
                    ) &&
                whse.branchCode!.toLowerCase().contains(
                      branchCode.toLowerCase(),
                    ),
          )
          .toList();
      return filtered;
    } else if (keyword != null &&
        keyword.isNotEmpty &&
        (branchCode == null || branchCode.isEmpty)) {
      var filtered = _datas
          .where(
            (whse) => whse.code.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    } else if (branchCode != null &&
        branchCode.isNotEmpty &&
        (keyword == null || keyword.isEmpty)) {
      var filtered = _datas
          .where(
            (whse) => whse.branchCode!.toLowerCase().contains(
                  branchCode.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
