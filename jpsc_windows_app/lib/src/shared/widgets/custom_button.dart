import 'package:clipboard/clipboard.dart';
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

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
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
      child: FilledButton(
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

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
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
      child: TextButton(
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

class CopyButton extends StatefulWidget {
  const CopyButton({Key? key, required this.value, this.style})
      : super(key: key);

  final String value;
  final TextStyle? style;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  void _showCopiedSnackbar(BuildContext context, String copiedText) {
    showSnackbar(
      context,
      Snackbar(
        content: RichText(
          text: TextSpan(
            text: 'Copied ',
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: copiedText,
                style: TextStyle(
                  color: Colors.blue.resolveFromReverseBrightness(
                    FluentTheme.of(context).brightness,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        extended: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () async {
        final copyText = widget.value;
        await FlutterClipboard.copy(copyText);
        if (mounted) _showCopiedSnackbar(context, copyText);
      },
      cursor: SystemMouseCursors.copy,
      builder: (context, states) {
        return FocusBorder(
          focused: states.isFocused,
          renderOutside: false,
          child: Tooltip(
            useMousePosition: false,
            message: '\n${widget.value}\n(tap to copy to clipboard)\n',
            child: RepaintBoundary(
              child: AnimatedContainer(
                duration: FluentTheme.of(context).fasterAnimationDuration,
                decoration: BoxDecoration(
                  color: ButtonThemeData.uncheckedInputColor(
                    FluentTheme.of(context),
                    states,
                  ),
                  // borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.value,
                  style: widget.style,
                  // overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
