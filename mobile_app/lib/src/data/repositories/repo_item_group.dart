import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class ItemGroupRepo {
  SharedPreferences localStorage;
  final api = baseAPI;

  final String _urlPath = ConstantURLPath.itemGroup;

  ItemGroupRepo({required this.localStorage});

  List<ItemGroupModel> _datas = [];
  List<ItemGroupModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll() async {
    Response response;

    response = await api.get(token: _token, pathUrl: _urlPath);
    _datas = List<ItemGroupModel>.from(
        response.data['data'].map((e) => ItemGroupModel.fromJson(e))).toList();
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(
      _token,
      pathUrl: _urlPath,
      data: data,
    );

    return response.data['message'];
  }

  Future<String> update(
      {required String fk, required Map<String, dynamic> data}) async {
    Response response;

    response = await api.update(
      _token,
      pathUrl: _urlPath + fk,
      data: data,
    );
    return response.data['message'];
  }

  Future<List<ItemGroupModel>> offlineSearch(String value) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (value.isNotEmpty) {
      var filtered = _datas
          .where(
            (itemGroup) => itemGroup.code.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
