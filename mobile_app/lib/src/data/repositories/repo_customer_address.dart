import 'package:dio/dio.dart';
import 'package:mobile_app/src/data/http_services/backend_api/base_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class CustomerAddressRepo {
  SharedPreferences localStorage;

  CustomerAddressRepo({
    required this.localStorage,
  });

  final api = baseAPI;

  final String _urlPath = ConstantURLPath.customerAddress;

  // List<CustomerAddressModel> _datas = [];
  // List<CustomerAddressModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  // Future<void> getAll() async {
  //   Response response;

  //   response = await api.get(token: _token, pathUrl: _urlPath);
  //   _datas = List<BranchModel>.from(
  //       response.data['data'].map((e) => BranchModel.fromJson(e))).toList();
  // }

  Future<Map<String, dynamic>> createCustomerAddress({
    required String customerCode,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    response = await api.create(_token,
        pathUrl: "$_urlPath/$customerCode/", data: data);
    return {
      "message": response.data['message'],
      "data": CustomerAddressModel.fromJson(response.data['data'])
    };
  }
}
