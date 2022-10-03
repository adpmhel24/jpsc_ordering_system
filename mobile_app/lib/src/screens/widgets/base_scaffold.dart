import 'package:flutter/material.dart';

import 'side_menu.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    required this.appbarTitle,
    required this.body,
    this.scaffoldKey,
    this.actions,
  }) : super(key: key);

  final String appbarTitle;
  final Widget body;
  final List<Widget>? actions;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
        actions: actions,
      ),
      key: scaffoldKey,
      drawer: const SideMenu(),
      body: body,
    );
  }
}
