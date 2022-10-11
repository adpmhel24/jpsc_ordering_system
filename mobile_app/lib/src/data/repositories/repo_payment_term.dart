import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class PaymentTermRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String _urlPath = ConstantURLPath.paymentTerms;

  PaymentTermRepo({
    required this.localStorage,
  });

  List<PaymentTermsModel> _datas = [];
  List<PaymentTermsModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      pathUrl: _urlPath,
      params: params,
    );
    _datas = List<PaymentTermsModel>.from(
            response.data['data'].map((e) => PaymentTermsModel.fromJson(e)))
        .toList();
  }

  Future<void> getByLocation(String location) async {
    Response response;

    response = await api.getAll(
      _token,
      pathUrl: "$_urlPath$location",
    );
    _datas = List<PaymentTermsModel>.from(
            response.data['data'].map((e) => PaymentTermsModel.fromJson(e)))
        .toList();
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

  Future<String> update({
    required String fk,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    response = await api.update(
      _token,
      pathUrl: "$_urlPath$fk",
      data: data,
    );
    return response.data['message'];
  }

  Future<List<PaymentTermsModel>> offlineSearch(String? keyword) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (keyword != null && keyword.isNotEmpty) {
      var filtered = _datas
          .where(
            (item) => item.code.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
