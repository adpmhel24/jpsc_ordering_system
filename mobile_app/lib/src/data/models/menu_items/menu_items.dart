import 'package:flutter/material.dart';

class MenuItems<R> {
  String name;
  Widget icon;
  R? route;

  MenuItems({
    required this.name,
    required this.icon,
    this.route,
  });
}
