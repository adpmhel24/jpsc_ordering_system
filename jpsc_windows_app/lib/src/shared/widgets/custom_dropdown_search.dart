import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../utils/responsive.dart';

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
    this.dropdownDecoratorProps = const DropDownDecoratorProps(),
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
  final DropDownDecoratorProps dropdownDecoratorProps;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      autoValidateMode: autoValidateMode,
      enabled: enable ?? true,
      items: items ?? [],
      popupProps: Responsive.isMobile(context)
          ? PopupProps.dialog(
              showSelectedItems: true,
              showSearchBox: true,
              isFilterOnline: true,
              loadingBuilder: (context, value) {
                return const Center(
                  child: ProgressRing(),
                );
              },
            )
          : PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              isFilterOnline: true,
              loadingBuilder: (context, value) {
                return const Center(
                  child: ProgressRing(),
                );
              },
            ),
      itemAsString: itemAsString,
      dropdownBuilder: dropdownBuilder,
      clearButtonProps: const ClearButtonProps(
        isVisible: true,
        icon: Icon(FluentIcons.clear, size: 12),
        splashRadius: 15,
      ),
      asyncItems: onFind,
      selectedItem: selectedItem,
      dropdownDecoratorProps: dropdownDecoratorProps,
      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(FluentIcons.caret_down8, size: 12),
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
