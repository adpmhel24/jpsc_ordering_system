import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart' as m;

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_dropdown_search.dart';
import 'bloc/itemform_bloc.dart';

class ItemFormBody extends StatefulWidget {
  const ItemFormBody({
    Key? key,
    this.selectedItem,
  }) : super(key: key);
  final ProductModel? selectedItem;

  @override
  State<ItemFormBody> createState() => _ItemFormBodyState();
}

class _ItemFormBodyState extends State<ItemFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _itemGrpController = TextEditingController();
  final TextEditingController _uomGrpController = TextEditingController();
  final TextEditingController _saleUomController = TextEditingController();
  final TextEditingController _purchasingUomController =
      TextEditingController();
  final TextEditingController _invUomController = TextEditingController();
  late ItemFormBloc formBloc;

  /// will hold the selected item group
  ItemGroupModel? _selectedItemGroup;

  /// Uom Choices depends on selected uom Group
  final ValueNotifier<List<UomModel>> _uoms = ValueNotifier([]);
  bool _isActive = true;

  @override
  void initState() {
    formBloc = context.read<ItemFormBloc>();
    final selectedItem = widget.selectedItem;
    if (selectedItem != null) {
      _codeController.text = selectedItem.code;
      _descriptionController.text = selectedItem.description ?? "";
      _itemGrpController.text = selectedItem.itemGroupCode ?? "";
      _saleUomController.text = selectedItem.saleUomCode ?? "";
      _selectedItemGroup = selectedItem.itemGroup;
      _isActive = selectedItem.isActive;
    }
    _fetchAllUom();
    formBloc.add(IsActiveChanged(_isActive));
    super.initState();
  }

  void _fetchAllUom() async {
    await context.read<UomRepo>().getAll();
    if (mounted) {
      _uoms.value = context.read<UomRepo>().datas;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _itemGrpController.dispose();
    _uomGrpController.dispose();
    _saleUomController.dispose();
    _purchasingUomController.dispose();
    _invUomController.dispose();
    _uoms.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: Responsive.isDesktop(context) ? .5 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  _codeField(),
                  Responsive.isMobile(context)
                      ? Constant.heightSpacer
                      : Constant.widthSpacer,
                  _descriptField(),
                ],
              ),
              Constant.heightSpacer,
              Flex(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  _itemGroupField(),
                  Responsive.isMobile(context)
                      ? Constant.heightSpacer
                      : Constant.widthSpacer,
                  _saleUomField(),
                ],
              ),
              Constant.heightSpacer,
              Constant.heightSpacer,
              Checkbox(
                checked: _isActive,
                content: const Text("Active"),
                onChanged: (value) {
                  setState(() => _isActive = value!);
                  formBloc.add(IsActiveChanged(_isActive));
                },
              ),
              Constant.heightSpacer,
              _createUpdateButton()
            ],
          ),
        );
      },
    );
  }

  Flexible _codeField() {
    return Flexible(
      child: TextFormBox(
        header: "Item Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        onChanged: (_) {
          formBloc.add(CodeChanged(_codeController));
        },
        validator: (_) {
          return formBloc.state.code.invalid ? "Provide item code." : null;
        },
      ),
    );
  }

  Flexible _descriptField() {
    return Flexible(
      child: TextFormBox(
        header: "Item Description",
        controller: _descriptionController,
        onChanged: (_) {
          formBloc.add(DescriptionChanged(_descriptionController));
        },
      ),
    );
  }

  Flexible _itemGroupField() {
    return Flexible(
      child: InfoLabel(
        label: "Item Group",
        child: m.Material(
          child: MyCustomDropdownSearch<ItemGroupModel>(
            autoValidateMode: AutovalidateMode.always,
            selectedItem: _selectedItemGroup,
            itemAsString: (itemGroup) => itemGroup!.code,
            onFind: (String? filter) =>
                context.read<ItemGroupRepo>().offlineSearch(filter!),
            compareFn: (item, selectedItem) => item!.code == selectedItem!.code,
            onChanged: (ItemGroupModel? data) {
              _itemGrpController.text = data?.code ?? "";
              formBloc.add(
                ItemGroupChanged(_itemGrpController),
              );
            },
            validator: (_) => formBloc.state.formzItemGroup.invalid
                ? "Provide item group."
                : null,
          ),
        ),
      ),
    );
  }

  Flexible _saleUomField() {
    return Flexible(
      child: InfoLabel(
        label: "Sale Uom",
        child: m.Material(
          child: ValueListenableBuilder<List<UomModel>>(
              valueListenable: _uoms,
              builder: (context, datas, _) {
                return MyCustomDropdownSearch<String>(
                  selectedItem: _saleUomController.text,
                  itemAsString: (data) => data!,
                  items: datas.map((e) => e.code).toList(),
                  compareFn: (data, selectedData) => data == selectedData,
                  onChanged: (String? data) {
                    _saleUomController.text = data ?? "";
                    formBloc.add(
                      SaleUomChanged(_saleUomController),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  MouseRegion _createUpdateButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context.watch<ItemFormBloc>().state.status.isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    if (widget.selectedItem != null) {
                      // formBloc.add(
                      //   CreateButtonSubmitted(),
                      // );
                    } else {
                      formBloc.add(
                        CreateButtonSubmitted(),
                      );
                    }
                    cntx.router.pop();
                  },
                );
              }
            : null,
        child: widget.selectedItem != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }
}
