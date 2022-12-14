import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile_app/src/data/http_services/backend_api/base_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> getAll() async {
    Response response;

    response = await api.get(token: _token, pathUrl: _urlPath);
    _datas = List<CustomerModel>.from(
        response.data['data'].map((e) => CustomerModel.fromJson(e))).toList();
  }

  Future<List<CustomerModel>> getCustomerByLocation({
    String? branchCode,
    Map<String, dynamic>? params,
  }) async {
    Response response;
    try {
      response = await api.get(
        token: _token,
        pathUrl: "$_urlPath/by_location/$branchCode",
        params: params,
      );
      _datas = List<CustomerModel>.from(
          response.data['data'].map((e) => CustomerModel.fromJson(e))).toList();
    } on HttpException catch (_) {
      _datas = [];
    }
    return _datas;
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, pathUrl: '$_urlPath/', data: data);
    return response.data['message'];
  }

  Future<Map<String, dynamic>> updateByField(
      {required String customerCode,
      required Map<String, dynamic> data}) async {
    Response response;

    response = await api.update(
      _token,
      pathUrl: '$_urlPath/by_field/$customerCode',
      data: data,
    );
    return {"message": response.data['message'], "data": response.data['data']};
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
