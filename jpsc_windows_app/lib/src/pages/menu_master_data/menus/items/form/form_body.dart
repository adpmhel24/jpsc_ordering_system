import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart' as m;
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
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

  /// Uom Choices depends on selected uom Group
  final ValueNotifier<List<UomModel>> _uoms = ValueNotifier([]);
  final ValueNotifier<List<ItemGroupModel>> _itemGroups = ValueNotifier([]);
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
      _isActive = selectedItem.isActive;
    }
    _loadInitialdata();
    formBloc.add(IsActiveChanged(_isActive));
    super.initState();
  }

  void _loadInitialdata() async {
    final uomRepo = context.read<UomRepo>();
    final itemGroupRepo = context.read<ItemGroupRepo>();
    context.loaderOverlay.show();
    try {
      await uomRepo.getAll();
      await itemGroupRepo.getAll();
      _uoms.value = uomRepo.datas;
      _itemGroups.value = itemGroupRepo.datas;
      context.loaderOverlay.hide();
    } on HttpException catch (e) {
      context.loaderOverlay.hide();
      CustomDialogBox.errorMessage(context, message: e.message);
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
    _itemGroups.dispose();
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
      child: ValueListenableBuilder<List<ItemGroupModel>>(
        valueListenable: _itemGroups,
        builder: (context, datas, _) {
          return AutoSuggestBox.form(
            autovalidateMode: AutovalidateMode.always,
            controller: _itemGrpController,
            items: datas
                .map<AutoSuggestBoxItem>(
                  (e) => AutoSuggestBoxItem(
                    label: "Item Group",
                    value: e.code,
                    child: Text(e.code),
                    onSelected: () {
                      _itemGrpController.text = e.code;
                      formBloc.add(
                        ItemGroupChanged(_itemGrpController.text),
                      );
                    },
                  ),
                )
                .toList(),
            onChanged: (value, reason) {
              String? itemGroupCode = datas
                  .firstWhereOrNull((element) => element.code == value)
                  ?.code;
              formBloc.add(
                ItemGroupChanged(itemGroupCode ?? ""),
              );
            },
            validator: (_) {
              return formBloc.state.formzItemGroup.invalid
                  ? "Invalid item group code"
                  : null;
            },
          );
        },
      ),
    );
  }

  Flexible _saleUomField() {
    return Flexible(
      child: m.Material(
        child: ValueListenableBuilder<List<UomModel>>(
            valueListenable: _uoms,
            builder: (context, datas, _) {
              return AutoSuggestBox.form(
                autovalidateMode: AutovalidateMode.always,
                controller: _saleUomController,
                items: datas
                    .map<AutoSuggestBoxItem>(
                      (e) => AutoSuggestBoxItem(
                        label: "Sale Uom",
                        value: e.code,
                        child: Text(e.code),
                        onSelected: () {
                          _saleUomController.text = e.code;
                          formBloc.add(
                            SaleUomChanged(_saleUomController.text),
                          );
                        },
                      ),
                    )
                    .toList(),
                onChanged: (value, reason) {
                  String? uomCode = datas
                      .firstWhereOrNull((element) => element.code == value)
                      ?.code;
                  formBloc.add(
                    SaleUomChanged(uomCode ?? ""),
                  );
                },
                validator: (_) {
                  return formBloc.state.formzSaleUom.invalid
                      ? "Invalid pricelist code"
                      : null;
                },
              );
            }),
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
                    formBloc.add(ButtonSubmitted());
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
