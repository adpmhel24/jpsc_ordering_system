import 'dart:io';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class CustomerRepo {
  SharedPreferences localStorage;

  CustomerRepo({
    required this.localStorage,
  });

  final api = baseAPI;

  final String _urlPath = ConstantURLPath.customer;

  List<CustomerModel> _datas = [];
  List<CustomerModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(_token, urlPath: _urlPath, params: params);
    _datas = List<CustomerModel>.from(
        response.data['data'].map((e) => CustomerModel.fromJson(e))).toList();
  }

  Future<List<CustomerModel>> getByLocationWithSearchOffline({
    String? branchCode,
    Map<String, dynamic>? params,
    String? keyword,
  }) async {
    Response response;
    try {
      response = await api.getAll(
        _token,
        urlPath: "$_urlPath/by_location/$branchCode",
        params: params,
      );
      _datas = List<CustomerModel>.from(
          response.data['data'].map((e) => CustomerModel.fromJson(e))).toList();
    } on HttpException catch (_) {
      _datas = [];
    }
    return await offlineSearch(keyword ?? "");
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, urlPath: _urlPath, data: data);
    return response.data['message'];
  }

  Future<String> bulkInsert({required List<Map<String, dynamic>> datas}) async {
    Response response;

    response = await api.bulkInsert(
      _token,
      urlPath: "${_urlPath}bulk_insert",
      datas: datas,
    );
    return response.data['message'];
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

  Future<List<CustomerModel>> offlineSearch(String value) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (value.isNotEmpty) {
      var filtered = _datas
          .where(
            (customer) => customer.code.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
