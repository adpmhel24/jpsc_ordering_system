import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_blocs/main_nav_bloc/bloc.dart';
import 'components/body.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const routeName = 'DashboardPage';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutoRouteAwareStateMixin<DashboardPage> {
  @override
  void didPush() {
    context.read<NavMenuCubit>().currentMenu(DashboardPage.routeName);
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return const DashboardBody();
    // return const OpenTextPage();
  }
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Screen that shows an example of openFile
// class OpenTextPage extends StatelessWidget {
//   /// Default Constructor
//   const OpenTextPage({Key? key}) : super(key: key);

//   Future<void> _openTextFile(BuildContext context) async {
//     const XTypeGroup typeGroup = XTypeGroup(
//       label: 'csv',
//       extensions: <String>['csv'],
//     );
//     // This demonstrates using an initial directory for the prompt, which should
//     // only be done in cases where the application can likely predict where the
//     // file would be. In most cases, this parameter should not be provided.
//     final String initialDirectory =
//         (await getApplicationDocumentsDirectory()).path;
//     final XFile? file = await openFile(
//       acceptedTypeGroups: <XTypeGroup>[typeGroup],
//       initialDirectory: initialDirectory,
//     );
//     if (file == null) {
//       // Operation was canceled by the user.
//       return;
//     }
//     final String filePath = file.path;

//     final csvFile = File(filePath).openRead();
//     var data = await csvFile
//         .transform(utf8.decoder)
//         .transform(
//           const CsvToListConverter(),
//         )
//         .toList();

//     // await showDialog<void>(
//     //   context: context,
//     //   builder: (BuildContext context) => TextDisplay(fileName, fileContent),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldPage(
//       header: const PageHeader(
//         title: Text('Open a text file'),
//       ),
//       content: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FilledButton(
//               child: const Text('Press to open a text file (csv)'),
//               onPressed: () => _openTextFile(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

