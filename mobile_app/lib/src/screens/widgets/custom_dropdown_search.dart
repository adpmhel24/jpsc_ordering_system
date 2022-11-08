import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class MyCustomDropdownSearch<T> extends StatelessWidget {
  const MyCustomDropdownSearch({
    Key? key,
    this.itemAsString,
    this.dropdownBuilder,
    this.compareFn,
    this.onFind,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
    this.selectedItem,
    this.items,
    this.enable,
    this.showClearButton,
    this.dropdownDecoratorProps,
    this.labelText,
    this.itemBuilder,
    this.prefixIcon,
    this.prefix,
    this.filterFn,
  }) : super(key: key);

  /// (item) => item!.name
  final String Function(T?)? itemAsString;
  final Widget Function(BuildContext, T?)? dropdownBuilder;

  /// Example: (item, selectedItem) => item!.name == selectedItem!.name
  final bool Function(T?, T?)? compareFn;

  ///Example: (String? filter) => context.read<BranchRepo>().offlineSearch(filter!),
  final Future<List<T>> Function(String?)? onFind;

  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final AutovalidateMode? autoValidateMode;
  final T? selectedItem;
  final List<T>? items;
  final bool? enable;
  final bool? showClearButton;
  final DropDownDecoratorProps? dropdownDecoratorProps;
  final String? labelText;
  final Widget Function(BuildContext, T, bool)? itemBuilder;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool Function(T, String)? filterFn;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      autoValidateMode: autoValidateMode,
      enabled: enable ?? true,
      items: items ?? [],
      filterFn: filterFn,
      popupProps: Responsive.isMobile(context)
          ? PopupProps.modalBottomSheet(
              showSelectedItems: true,
              showSearchBox: true,
              isFilterOnline: true,
              itemBuilder: itemBuilder,
              searchFieldProps: TextFieldProps(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0),
                  ),
                ),
              ),
              modalBottomSheetProps: ModalBottomSheetProps(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700
                    : null,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              loadingBuilder: (context, value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            )
          : PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              isFilterOnline: true,
              itemBuilder: itemBuilder,
              loadingBuilder: (context, value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            ),
      itemAsString: itemAsString,
      dropdownBuilder: dropdownBuilder,
      clearButtonProps: const ClearButtonProps(
        isVisible: true,
        icon: Icon(Icons.clear, size: 15),
        splashRadius: 15,
      ),
      asyncItems: onFind,
      selectedItem: selectedItem,
      dropdownDecoratorProps: dropdownDecoratorProps ??
          DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
              filled: true,
              // fillColor: const Color(0xFFeeeee4),
              labelText: labelText,
              prefixIcon: prefixIcon,
              prefix: prefix,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),

      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(Icons.arrow_drop_down, size: 15),
        splashRadius: 15,
      ),
      // dropdownSearchDecoration: m.InputDecoration(
      //   border: m.OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   contentPadding: const EdgeInsets.symmetric(
      //     horizontal: 10,
      //   ),
      // ),

      compareFn: compareFn,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
