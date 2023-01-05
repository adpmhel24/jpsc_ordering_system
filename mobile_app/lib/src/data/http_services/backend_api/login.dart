import 'package:dio/dio.dart';

import 'utils/custom_throw_error.dart';
import 'utils/dio_settings.dart';

class LoginAPI {
  final Dio _dio = DioSettings.dio();

  Future<Response> login(Map<String, dynamic> data) async {
    Response response;
    FormData formData = FormData.fromMap(data);

    try {
      response = await _dio.post(
        '/api/v1/login/access-token',
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }),
      );
    } on DioError catch (e) {
      throw CustomThrowError.throwError(e);
    }
    return response;
  }

  Future<Response> tryLogin(String token) async {
    Response response;

    try {
      response = await _dio.post(
        '/api/v1/try_login',
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

  ///Singleton factory
  static final LoginAPI _instance = LoginAPI._internal();

  factory LoginAPI() {
    return _instance;
  }

  LoginAPI._internal();
}
