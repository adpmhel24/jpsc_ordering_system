import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/login.dart';
import '../models/models.dart';
import 'repos.dart';

enum LoginStatus { init, checking, loggedin, loggedout, error }

class CurrentUserRepo {
  late LoginAPI loginApi = LoginAPI();
  late SharedPreferences localStorage = LocalStorageRepo().localStorage;

  SystemUserModel? _currentUser;
  LoginStatus _loginStatus = LoginStatus.init;

  // Getter
  LoginStatus get loginStatus => _loginStatus;
  SystemUserModel get currentUser => _currentUser!;

  // Setter
  // set(bool value) {
  //   _isAuthenticated = value;
  //   notifyListeners();
  // }

  Future<void> checkIfLoggedIn() async {
    String user = localStorage.getString('userData') ?? "";
    String accessToken = localStorage.getString("access_token") ?? "";
    if (accessToken.isEmpty) {
      _loginStatus = LoginStatus.loggedout;
    } else if (accessToken.isNotEmpty) {
      await loginApi.tryLogin(accessToken);

      _currentUser = SystemUserModel.fromJson(json.decode(user));
      _loginStatus = LoginStatus.loggedin;
    } else {
      _loginStatus = LoginStatus.loggedout;
    }
  }

  bool checkIfUserAuthorized({
    required int objtype,
    required Map<String, dynamic> auths,
  }) {
    bool authorized = false;
    if (_currentUser!.isSuperAdmin) {
      return true;
    }
    AuthorizationModel? authorization = currentUser.authorizations
        ?.firstWhereOrNull((e) => e.objtype == objtype);

    if (authorization != null) {
      auths.forEach(
        (key, value) {
          if (authorization.toJson()[key] && value) {
            authorized = true;
          }
        },
      );
    }

    return authorized;
  }

  bool checkIfGrantToViewLastPurch(String itemGroupCode) {
    return _currentUser?.itemGroupAuth
            ?.firstWhereOrNull(
                (element) => element.itemGroupCode == itemGroupCode)
            ?.grantLastPurc ??
        false;
  }

  bool checkIfGrantToViewAvgSAP(String itemGroupCode) {
    return _currentUser?.itemGroupAuth
            ?.firstWhereOrNull(
                (element) => element.itemGroupCode == itemGroupCode)
            ?.grantAvgValue ??
        false;
  }

  Future<void> loginWithCredentials(Map<String, dynamic> data) async {
    Response response;
    response = await loginApi.login(data);
    _currentUser = SystemUserModel.fromJson(response.data['data']);
    localStorage.setString("userData", json.encode(_currentUser!.toJson()));
    localStorage.setString("access_token", response.data['access_token']);
    localStorage.setString(
        "currUserBranch", json.encode(_currentUser!.assignedBranch));

    // Load or resources after autheticate
    // await AppRepo().init();
    _loginStatus = LoginStatus.loggedout;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    localStorage.remove("userData");
    localStorage.remove("access_token");
    localStorage.remove("currUserBranch");
    _currentUser = null;

    // Change the value of authenticated then notify
    _loginStatus = LoginStatus.loggedout;
  }

  ///Singleton factory
  static final CurrentUserRepo _instance = CurrentUserRepo._internal();
  CurrentUserRepo._internal();

  factory CurrentUserRepo() {
    return _instance;
  }
}
