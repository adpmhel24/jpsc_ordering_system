import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class ObjectTypeRepo {
  SharedPreferences localStorage;

  ObjectTypeRepo({
    required this.localStorage,
  });

  final api = baseAPI;

  final String _urlPath = ConstantURLPath.objtype;

  List<ObjectTypeModel> _datas = [];
  List<ObjectTypeModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(_token, urlPath: _urlPath, params: params);
    _datas = List<ObjectTypeModel>.from(
        response.data['data'].map((e) => ObjectTypeModel.fromJson(e))).toList();
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, urlPath: _urlPath, data: data);
    return response.data['message'];
  }

  Future<int> getObjectTypeByName(String name) async {
    if (_datas.isEmpty) {
      await getAll();
    }
    return _datas.firstWhere((e) => e.name == name).id;
  }

  Future<String> update(
      {required String customerCode,
      required Map<String, dynamic> data}) async {
    Response response;

    response = await api.update(
      _token,
      urlPath: _urlPath + customerCode,
      data: data,
    );
    return response.data['message'];
  }
}
