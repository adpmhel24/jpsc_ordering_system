import 'package:flutter/foundation.dart';

import 'interceptors.dart';
import 'package:dio/dio.dart';

class DioSettings {
  static Dio dio() {
    String url;

    if (kReleaseMode) {
      // release mode
      url = "http://122.54.198.84:8800";
    } else {
      // debug mode
      // url = "http://192.168.1.4:8001";
      // url = "http://192.168.2.251:8800";
      url = "http://192.168.2.245:8800";
      // url = "http://122.54.198.84:8800";
    }
    return Dio(
      BaseOptions(
        baseUrl: url,
      ),
    )..interceptors.add(Logging());
  }

  ///Singleton factory
  static final DioSettings _instance = DioSettings._internal();

  factory DioSettings() {
    return _instance;
  }

  DioSettings._internal();
}

var dio = DioSettings.dio();
