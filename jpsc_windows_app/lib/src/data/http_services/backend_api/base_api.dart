import 'package:dio/dio.dart';

import 'utils/custom_throw_error.dart';
import 'utils/dio_settings.dart';

class BaseAPI {
  final Dio _dio = dio;

  Future<Response> create(
    String token, {
    required String urlPath,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    try {
      response = await _dio.post(
        urlPath,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> getAll(
    String token, {
    required String urlPath,
    Map<String, dynamic>? params,
  }) async {
    Response response;

    try {
      response = await _dio.get(
        urlPath,
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> update(
    String token, {
    required String urlPath,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    try {
      response = await _dio.put(
        urlPath,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> bulkUpdate(
    String token, {
    required String urlPath,
    required List<Map<String, dynamic>> datas,
  }) async {
    Response response;

    try {
      response = await _dio.put(
        urlPath,
        data: datas,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> bulkInsert(
    String token, {
    required String urlPath,
    required List<Map<String, dynamic>> datas,
  }) async {
    Response response;

    try {
      response = await _dio.post(
        urlPath,
        data: datas,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> formDataPost(String token,
      {required String urlPath, required Map<String, dynamic> data}) async {
    Response response;

    FormData formData = FormData.fromMap(data);

    try {
      response = await dio.post(
        urlPath,
        data: formData,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
          responseType: ResponseType.json,
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> getByFk(
    String token, {
    required String urlPath,
    required dynamic fk,
  }) async {
    Response response;

    try {
      response = await _dio.get(
        urlPath + fk,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> cancel(
    String token, {
    required String urlPath,
    required String fk,
    Map<String, dynamic>? data,
  }) async {
    Response response;

    try {
      response = await _dio.put(
        urlPath + fk,
        data: data,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }
}

var baseAPI = BaseAPI();
