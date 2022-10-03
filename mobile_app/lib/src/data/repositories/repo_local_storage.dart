import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepo {
  late SharedPreferences _localStorage;

  SharedPreferences get localStorage => _localStorage;

  Future init() async {
    _localStorage = await SharedPreferences.getInstance();
  }

  ///Singleton factory
  static final LocalStorageRepo _instance = LocalStorageRepo._internal();

  factory LocalStorageRepo() {
    return _instance;
  }

  LocalStorageRepo._internal();
}
