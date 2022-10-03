import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    Key? key,
    required this.message,
    required this.buttonLabel,
    required this.onButtonPressed,
    this.submessage,
  }) : super(key: key);
  final String message;
  final String? submessage;
  final String buttonLabel;
  final void Function(BuildContext)? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
                Constant.heightSpacer,
                Text(
                  message,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Constant.heightSpacer,
                Text(
                  submessage ?? "",
                  style: const TextStyle(color: Color(0xFF164052)),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (onButtonPressed != null) {
                onButtonPressed!(context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home),
                Constant.heightSpacer,
                Text(buttonLabel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
