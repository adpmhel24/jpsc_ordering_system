import 'package:flutter/material.dart';

class MenuController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  late String currentMenu = "";

  void controlMenu(String currentMenu) {
    currentMenu = currentMenu;
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      _scaffoldKey.currentState!.openEndDrawer();
    }
  }
}
