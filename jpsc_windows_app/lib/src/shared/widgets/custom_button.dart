import 'package:fluent_ui/fluent_ui.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autoFocus = false,
    this.style,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Button(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autoFocus,
        style: style,
        child: child,
      ),
    );
  }
}
