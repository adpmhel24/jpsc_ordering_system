import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'custom_text_field.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController _controller;
  final DateFormat _dateFormat;
  final Widget? _suffixIcon;
  final String labelText;

  final Function(DateTime)? onDateConfirm;

  const CustomDateField({
    Key? key,
    required TextEditingController controller,
    required DateFormat dateFormat,
    required this.labelText,
    Widget? suffixIcon,
    this.onDateConfirm,
  })  : _controller = controller,
        _dateFormat = dateFormat,
        _suffixIcon = suffixIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      controller: _controller,
      labelText: labelText,
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2100, 12, 31),
          onConfirm: (date) {
            _controller.text = _dateFormat.format(date);
            if (onDateConfirm != null) {
              onDateConfirm!(date);
            }
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      prefixIcon: const Icon(Icons.calendar_today),
      suffixIcon: _suffixIcon,
    );
  }
}
