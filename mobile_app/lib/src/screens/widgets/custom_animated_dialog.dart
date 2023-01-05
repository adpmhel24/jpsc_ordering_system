import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomAnimatedDialog {
  static Future<Object?> warning(
    BuildContext context, {
    required String message,
    void Function(BuildContext)? onPositiveClick,
    void Function()? onNegativeClick,
  }) {
    return showAnimatedDialog(
      context: context,
      builder: (BuildContext cntx) {
        return ClassicGeneralDialogWidget(
          titleText: 'Warning!',
          contentText: message,
          negativeText: 'Cancel',
          positiveText: 'Okay',
          onNegativeClick: (onNegativeClick == null)
              ? Navigator.of(cntx).pop
              : onNegativeClick,
          onPositiveClick: () {
            Navigator.of(cntx).pop();

            if (onPositiveClick != null) {
              onPositiveClick(cntx);
            }
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  static Future<Object?> success({
    required BuildContext context,
    required String message,
    bool? barrierDismissible,
    void Function(BuildContext)? onPositiveClick,
  }) {
    context.loaderOverlay.hide();
    return showAnimatedDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext cntx) {
        return ClassicGeneralDialogWidget(
          titleText: 'Success!',
          contentText: message,
          positiveText: 'Okay',
          onPositiveClick: () {
            Navigator.of(cntx).pop();
            if (onPositiveClick != null) {
              onPositiveClick(cntx);
            }
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  static Future<Object?> newVersionAvailable({
    required BuildContext context,
    required String message,
    bool? barrierDismissible,
    void Function(BuildContext)? onPositiveClick,
  }) {
    context.loaderOverlay.hide();
    return showAnimatedDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext cntx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ClassicGeneralDialogWidget(
            titleText: 'Success!',
            contentText: message,
            positiveText: 'Okay',
            onPositiveClick: () {
              if (onPositiveClick != null) {
                onPositiveClick(cntx);
              }
            },
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }

  static Future<Object?> error(BuildContext context,
      {required String message,
      void Function()? onPositiveClick,
      bool? barrierDismissible}) {
    context.loaderOverlay.hide();
    return showAnimatedDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ClassicGeneralDialogWidget(
            titleText: 'Error!',
            contentText: message,
            positiveText: 'Okay',
            onPositiveClick: onPositiveClick ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }
}
