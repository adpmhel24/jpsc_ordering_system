import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class PriceQuotationRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String _urlPath = ConstantURLPath.pqRepo;

  PriceQuotationRepo({
    required this.localStorage,
  });

  List<PriceQuotationModel> _datas = [];
  List<PriceQuotationModel> get datas => _datas;

  int _forPriceConf = 0;
  int _forCreditConf = 0;
  int _forDispatch = 0;

  int get forPriceConf => _forPriceConf;
  int get forCreditConf => _forCreditConf;
  int get forDispatch => _forDispatch;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: _urlPath,
      params: params,
    );
    _datas = List<PriceQuotationModel>.from(
      response.data['data'].map(
        (e) => PriceQuotationModel.fromJson(e),
      ),
    ).toList();
    _forPriceConf = response.data["others"]["for_price_confirmation"];
    _forCreditConf = response.data["others"]["for_credit_confirmation"];
    _forDispatch = response.data["others"]["for_dispatch"];
  }

  Future<Map<String, dynamic>> getByCustomerCode(String customerCode,
      {Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: "${_urlPath}by_customer/$customerCode",
      params: params,
    );
    return response.data;
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(
      _token,
      urlPath: _urlPath,
      data: data,
    );

    return response.data['message'];
  }

  Future<void> getAllOrdersByOwner({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: "${_urlPath}by_owner",
      params: params,
    );
    _datas = List<PriceQuotationModel>.from(
            response.data['data'].map((e) => PriceQuotationModel.fromJson(e)))
        .toList();
  }

  Future<String> update({
    required Map<String, dynamic> data,
  }) async {
    Response response;

    response = await api.update(
      _token,
      urlPath: _urlPath,
      data: data,
    );
    return response.data['message'];
  }

  Future<PriceQuotationModel> getDetails({
    required int fk,
  }) async {
    Response response;
    response = await api.getByFk(
      _token,
      urlPath: _urlPath,
      fk: fk.toString(),
    );

    return PriceQuotationModel.fromJson(response.data['data']);
  }

  Future<String> cancel({
    required int fk,
    Map<String, dynamic>? data,
  }) async {
    Response response;
    response = await api.cancel(
      _token,
      urlPath: "${_urlPath}cancel/",
      fk: fk.toString(),
      data: data,
    );
    return response.data['message'];
  }
}
