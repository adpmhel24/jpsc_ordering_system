import 'package:flutter/material.dart';

class BorderedSelectableText extends StatefulWidget {
  const BorderedSelectableText({
    Key? key,
    required this.value,
    this.height,
    this.width,
  }) : super(key: key);

  final String value;
  final double? height;
  final double? width;

  @override
  State<BorderedSelectableText> createState() => _BorderedSelectableText();
}

class _BorderedSelectableText extends State<BorderedSelectableText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    BoxDecoration foregroundDecoration = BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: theme.brightness == Brightness.light
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
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SelectableText(widget.value),
    );
  }
}
