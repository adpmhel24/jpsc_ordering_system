import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../utils/constant.dart';
import 'custom_text_field.dart';

class CustomFieldModalChoices<T> extends StatefulWidget {
  const CustomFieldModalChoices({
    Key? key,
    TextEditingController? controller,
    required String labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    final TextInputAction? textInputAction,
    final AutovalidateMode? autovalidateMode,
    final String? Function(String?)? validator,
    required final List<T?> items,
    Function(String)? onChanged,
    Function(String)? onSearch,
    required Widget Function(BuildContext, int) itemBuilder,
  })  : _controller = controller,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _textInputAction = textInputAction,
        _autovalidateMode = autovalidateMode,
        _validator = validator,
        _onChanged = onChanged,
        _items = items,
        _itemBuilder = itemBuilder,
        _onSearch = onSearch,
        super(key: key);

  final TextEditingController? _controller;
  final String _labelText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final TextInputAction? _textInputAction;
  final AutovalidateMode? _autovalidateMode;
  final String? Function(String?)? _validator;
  final List<T?> _items;
  final Function(String)? _onChanged;
  final Widget Function(BuildContext, int) _itemBuilder;
  final Function(String)? _onSearch;

  @override
  State<CustomFieldModalChoices<T>> createState() =>
      _CustomFieldModalChoicesState<T>();
}

class _CustomFieldModalChoicesState<T>
    extends State<CustomFieldModalChoices<T>> {
  @override
  Widget build(BuildContext context) {
    var screenHeightSize = MediaQuery.of(context).size.height;
    return TextFormField(
      textInputAction: widget._textInputAction,
      autovalidateMode: widget._autovalidateMode,
      readOnly: true,
      keyboardType: TextInputType.none,
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (_) => SafeArea(
            child: SizedBox(
              height: (screenHeightSize * .75),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomTextField(
                        labelText: 'Search by keyword',
                        onChanged: widget._onSearch,
                      ),
                    ),
                  ),
                  Constant.heightSpacer,
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget._items.length,
                      itemBuilder: widget._itemBuilder,
                      separatorBuilder: (_, index) {
                        return const Divider(
                          thickness: 1,
                          color: Color(0xFFBDBDBD),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      controller: widget._controller,
      onChanged: widget._onChanged,
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
        labelText: widget._labelText,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget._prefixIcon,
        suffixIcon: widget._suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      ),
      validator: widget._validator,
    );
  }
}
