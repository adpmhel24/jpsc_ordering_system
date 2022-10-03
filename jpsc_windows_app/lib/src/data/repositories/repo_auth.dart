import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/login.dart';
import '../models/models.dart';
import 'repos.dart';

class AuthRepo extends ChangeNotifier {
  late LoginAPI loginApi = LoginAPI();
  late SharedPreferences localStorage = LocalStorageRepo().localStorage;

  AuthUserModel? _currentUser;
  bool _isAuthenticated = false;

  // Getter
  bool get isAuthenticated => _isAuthenticated;
  AuthUserModel get currentUser => _currentUser!;

  // Setter
  set(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void checkIfLoggedIn() {
    String user = localStorage.getString('userData') ?? "";
    if (user.isEmpty) {
      _isAuthenticated = false;
      notifyListeners();
    } else {
      _currentUser = AuthUserModel.fromJson(json.decode(user));
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> loginWithCredentials(Map<String, dynamic> data) async {
    Response response;
    response = await loginApi.login(data);
    _currentUser = AuthUserModel.fromJson(response.data['data']);
    localStorage.setString("userData", json.encode(_currentUser!.toJson()));
    localStorage.setString("access_token", response.data['access_token']);
    localStorage.setString(
        "currUserBranch", json.encode(_currentUser!.assignedBranch));

    // Load or resources after autheticate
    // await AppRepo().init();

    // Change the value of authenticated then notify
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    localStorage.remove("userData");
    localStorage.remove("access_token");
    localStorage.remove("currUserBranch");
    _currentUser = null;

    // Change the value of authenticated then notify
    _isAuthenticated = false;
    notifyListeners();
  }

  ///Singleton factory
  static final AuthRepo _instance = AuthRepo._internal();
  AuthRepo._internal();

  factory AuthRepo(
      // {required SharedPreferences localStorage, required LoginAPI loginApi}
      ) {
    // _instance.localStorage = localStorage;
    // _instance.loginApi = loginApi;
    return _instance;
  }
}
