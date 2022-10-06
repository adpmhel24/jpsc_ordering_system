import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class SalesOrderRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String _urlPath = ConstantURLPath.orderRepo;

  SalesOrderRepo({
    required this.localStorage,
  });

  List<SalesOrderModel> _datas = [];
  List<SalesOrderModel> get datas => _datas;

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
    _datas = List<SalesOrderModel>.from(
      response.data['data'].map(
        (e) => SalesOrderModel.fromJson(e),
      ),
    ).toList();
    _forPriceConf = response.data["others"]["for_price_confirmation"];
    _forCreditConf = response.data["others"]["for_credit_confirmation"];
    _forDispatch = response.data["others"]["for_dispatch"];
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
    _datas = List<SalesOrderModel>.from(
        response.data['data'].map((e) => SalesOrderModel.fromJson(e))).toList();
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

  // Future<InventoryAdjustmentInModel> getDetails({
  //   required int fk,
  // }) async {
  //   Response response;
  //   try {
  //     response = await api.getByFk(
  //       _token,
  //       urlPath: _urlPath,
  //       fk: fk.toString(),
  //     );
  //   } on HttpException catch (e) {
  //     throw HttpException(e.message);
  //   }
  //   return InventoryAdjustmentInModel.fromJson(response.data['data']);
  // }

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
