import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
    int? maxLength,
    String? Function(String?)? validator,
    bool? showCursor,
    bool? readOnly,
    Function()? onTap,
    TextAlign? textAlign,
    Function(String value)? onChanged,
    AutovalidateMode? autovalidateMode,
    TextStyle? labelStyle,
    bool? enabled,
    bool? obscureText,
    List<TextInputFormatter>? inputFormatters,
    String? initialValue,
    Widget? prefix,
  })  : _controller = controller,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _textInputAction = textInputAction,
        _keyboardType = keyboardType,
        _minLines = minLines,
        _maxLines = maxLines,
        _maxLength = maxLength,
        _validator = validator,
        _onTap = onTap,
        _showCursor = showCursor,
        _readOnly = readOnly,
        _textAlign = textAlign,
        _onChanged = onChanged,
        _autovalidateMode = autovalidateMode,
        _enabled = enabled,
        _obscureText = obscureText,
        _inputFormatters = inputFormatters,
        _initialValue = initialValue,
        _prefix = prefix,
        super(key: key);

  final TextEditingController? _controller;
  final String _labelText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final TextInputAction? _textInputAction;
  final TextInputType? _keyboardType;
  final int? _minLines;
  final int? _maxLines;
  final int? _maxLength;
  final String? Function(String?)? _validator;
  final bool? _showCursor;
  final bool? _readOnly;
  final Function()? _onTap;
  final TextAlign? _textAlign;
  final void Function(String value)? _onChanged;
  final AutovalidateMode? _autovalidateMode;
  final bool? _enabled;
  final bool? _obscureText;
  final List<TextInputFormatter>? _inputFormatters;
  final String? _initialValue;
  final Widget? _prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _initialValue,
      autovalidateMode: _autovalidateMode,
      textInputAction: _textInputAction,
      keyboardType: _keyboardType,
      inputFormatters: _inputFormatters,
      enabled: _enabled,
      controller: _controller,
      maxLength: _maxLength,
      minLines: _minLines ?? 1,
      maxLines: _maxLines ?? 1,
      showCursor: _showCursor,
      readOnly: _readOnly ?? false,
      onTap: _onTap,
      textAlign: _textAlign ?? TextAlign.start,
      obscureText: _obscureText ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        filled: true,
        labelText: _labelText,
        prefixIcon: _prefixIcon,
        prefix: _prefix,
        suffixIcon: _suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      validator: _validator,
      onChanged: _onChanged,
    );
  }
}
