import 'package:fluent_ui/fluent_ui.dart';

class BorderedText extends StatefulWidget {
  const BorderedText({
    Key? key,
    required this.child,
    this.height,
    this.width,
  }) : super(key: key);

  final Widget child;
  final double? height;
  final double? width;

  @override
  State<BorderedText> createState() => _BorderedTextState();
}

class _BorderedTextState extends State<BorderedText> {
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final Color backgroundColor = theme.resources.controlFillColorDefault;
    BoxDecoration foregroundDecoration = BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: theme.brightness.isLight
              ? const Color.fromRGBO(0, 0, 0, 0.45)
              : const Color.fromRGBO(255, 255, 255, 0.54),
        ),
      ),
    );

    return Container(
      height: widget.height,
      width: widget.width,
      foregroundDecoration: foregroundDecoration,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: widget.child,
    );
  }
}
