import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:intl/intl.dart';

import 'bordered_text.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.dateFormat,
    required this.date,
    this.height,
    this.width,
    required this.onChanged,
    this.isRemoveShow = false,
  }) : super(key: key);

  final String label;
  final double? height;
  final double? width;
  final DateTime? date;
  final DateFormat dateFormat;
  final Function(DateTime?) onChanged;
  final bool isRemoveShow;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: widget.label,
      child: BorderedText(
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              widget.date != null ? widget.dateFormat.format(widget.date!) : "",
              toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
            ),
            IconButton(
              icon: const Icon(FluentIcons.calendar),
              onPressed: () async {
                final newTime = await m.showDatePicker(
                  context: context,
                  initialDate: widget.date ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(9999),
                );
                if (newTime != null) {
                  widget.onChanged(newTime);
                }
              },
            ),
            if (widget.isRemoveShow)
              IconButton(
                icon: const Icon(FluentIcons.delete),
                onPressed: () {
                  widget.onChanged(null);
                },
              )
          ],
        ),
      ),
    );
  }
}
