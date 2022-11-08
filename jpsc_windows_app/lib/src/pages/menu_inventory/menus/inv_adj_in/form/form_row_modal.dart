import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/item_selection.dart';
import '../../../../../shared/widgets/warehouse_selection.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import 'bloc/bloc.dart';
import 'item_row_bloc/bloc.dart';

class FormRowModal extends StatelessWidget {
  const FormRowModal({
    Key? key,
    required this.invAdjInBloc,
    this.invAdjInItemRow,
  }) : super(key: key);

  final InvAdjustmentInFormBloc invAdjInBloc;
  final InventoryAdjustmentInRow? invAdjInItemRow;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemRowBloc(),
      child: BodyFormRowModal(
        invAdjInBloc: invAdjInBloc,
        invAdjInItemRow: invAdjInItemRow,
      ),
    );
  }
}

class BodyFormRowModal extends StatefulWidget {
  const BodyFormRowModal({
    Key? key,
    required this.invAdjInBloc,
    this.invAdjInItemRow,
  }) : super(key: key);

  final InvAdjustmentInFormBloc invAdjInBloc;
  final InventoryAdjustmentInRow? invAdjInItemRow;

  @override
  State<BodyFormRowModal> createState() => _BodyFormRowModalState();
}

class _BodyFormRowModalState extends State<BodyFormRowModal> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _whseController = TextEditingController();

  final ValueNotifier<List<AltUomModel>> _altUoms = ValueNotifier([]);
  final ValueNotifier<String?> _selectedUom = ValueNotifier("");

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  void dispose() {
    _itemController.dispose();
    _itemDescriptionController.dispose();
    _whseController.dispose();
    _quantityController.dispose();
    _altUoms.dispose();
    _selectedUom.dispose();
    super.dispose();
  }

  void initializeData() async {
    if (widget.invAdjInItemRow != null) {
      UomGroupModel? oumGroup = await context
          .read<ProductRepo>()
          .getUomGroupAssigned(widget.invAdjInItemRow!.itemCode);
      _onItemCodeFieldChanged(widget.invAdjInItemRow!.itemCode);
      _onItemDescFieldChanged(widget.invAdjInItemRow?.itemDescription ?? "");
      _onQuantityFieldChanged(widget.invAdjInItemRow!.quantity.toString());
      _onWhseFieldChanged(widget.invAdjInItemRow!.whsecode);

      if (oumGroup != null) {
        _handleUpdateAltUoms(oumGroup.altUoms!);
      }
      _onUomChanged(widget.invAdjInItemRow!.uom);
    }
  }

  void _handleUpdateAltUoms(List<AltUomModel> altUoms) {
    _altUoms.value = altUoms;
  }

  void _onUomChanged(String? value) {
    _selectedUom.value = value;
    context.read<ItemRowBloc>().add(UomChanged(_selectedUom.value ?? ""));
  }

  void _onItemCodeFieldChanged(String value) {
    _itemController.text = value;
    context.read<ItemRowBloc>().add(
          ItemCodeChanged(_itemController.text),
        );
  }

  void _onItemDescFieldChanged(String value) {
    _itemDescriptionController.text = value;
  }

  void _onQuantityFieldChanged(String value) {
    _quantityController.text = value;
    _quantityController.selection = TextSelection.fromPosition(
        TextPosition(offset: _quantityController.text.length));
    context.read<ItemRowBloc>().add(
          QuantityChanged(
            value.isEmpty ? null : double.parse(_quantityController.text),
          ),
        );
  }

  void _onWhseFieldChanged(String value) {
    _whseController.text = value;
    context.read<ItemRowBloc>().add(
          WarehouseChanged(_whseController.text),
        );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Builder(
      builder: (context) {
        return BlocBuilder<ItemRowBloc, ItemRowBlocState>(
          builder: (_, state) {
            return ContentDialog(
              title: const Text("Item Row Form"),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .6,
                  maxWidth: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width
                      : 600),
              actions: [
                _okButton(context, state),
                Constant.widthSpacer,
                _cancelButton(context),
              ],
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Flex(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      direction: Responsive.isMobile(context)
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        _itemCodeField(context, state),
                        (Responsive.isMobile(context))
                            ? Constant.heightSpacer
                            : Constant.widthSpacer,
                        _itemDescriptionField(),
                      ],
                    ),
                    Constant.heightSpacer,
                    Flex(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      direction: Responsive.isMobile(context)
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        _quantityField(context, state),
                        (Responsive.isMobile(context))
                            ? Constant.heightSpacer
                            : Constant.widthSpacer,
                        _uomField(),
                      ],
                    ),
                    Constant.heightSpacer,
                    _whseCodeField(context, state),
                    Constant.heightSpacer,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Flexible _itemDescriptionField() {
    return Flexible(
      child: TextBox(
        header: "Item Description",
        controller: _itemDescriptionController,
        enabled: false,
      ),
    );
  }

  TextFormBox _whseCodeField(BuildContext context, ItemRowBlocState state) {
    return TextFormBox(
      header: "Warehouse (required)",
      controller: _whseController,
      autovalidateMode: AutovalidateMode.always,
      readOnly: true,
      suffix: IconButton(
        onPressed: () {
          _onWhseFieldChanged("");
        },
        icon: const Icon(FluentIcons.delete),
      ),
      validator: (_) {
        return state.warehouse.invalid ? "Required field!" : null;
      },
      onTap: () {
        m.showDialog(
          context: context,
          useRootNavigator: false,
          builder: (_) => WarehouseSelectionModal(
            selectedWhse: _whseController.text,
            selectedBranch: widget.invAdjInBloc.state.branch.value,
            onChanged: (value) {
              _onWhseFieldChanged(value.code);
              context.router.pop();
            },
          ),
        );
      },
    );
  }

  Flexible _uomField() {
    return Flexible(
      child: InfoLabel(
        label: "Uom",
        child: ValueListenableBuilder<List<AltUomModel>>(
          valueListenable: _altUoms,
          builder: (context, data, wt) {
            return ValueListenableBuilder<String?>(
              valueListenable: _selectedUom,
              builder: (_, uomData, widget) {
                return ComboBox<String>(
                  placeholder: const Text('Select Uom'),
                  isExpanded: true,
                  items: data
                      .map((e) => ComboBoxItem<String>(
                            value: e.altUom,
                            child: Text(e.altUom),
                          ))
                      .toList(),
                  value: uomData,
                  onChanged: (value) {
                    _onUomChanged(
                      value,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Flexible _quantityField(BuildContext context, ItemRowBlocState state) {
    return Flexible(
      child: TextFormBox(
        header: "Quantity (required)",
        autovalidateMode: AutovalidateMode.always,
        controller: _quantityController,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        onChanged: (value) {
          _onQuantityFieldChanged(value);
        },
        validator: (_) {
          return state.quantity.invalid ? "Required field!" : null;
        },
      ),
    );
  }

  Widget _itemCodeField(BuildContext context, ItemRowBlocState state) {
    return Flexible(
      child: TextFormBox(
        header: "Item Code (required)",
        controller: _itemController,
        autovalidateMode: AutovalidateMode.always,
        suffix: IconButton(
          onPressed: () {
            _onItemCodeFieldChanged("");
            _onItemDescFieldChanged("");
          },
          icon: const Icon(FluentIcons.delete),
        ),
        validator: (_) {
          return state.itemCode.invalid ? "Required field!" : null;
        },
        readOnly: true,
        onTap: () {
          m.showDialog(
            context: context,
            useRootNavigator: false,
            builder: (_) => ItemSelectionModal(
              selectedItem: _itemController.text,
              itemRepo: context.read<ProductRepo>(),
              onChanged: (value) {
                _onItemCodeFieldChanged(value.code);
                _onItemDescFieldChanged(value.description ?? "");
                _handleUpdateAltUoms(value.uomGroup!.altUoms!);
                context.router.pop();
              },
            ),
          );
        },
      ),
    );
  }

  SizedBox _cancelButton(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CustomButton(
        style: ButtonStyle(
          padding: ButtonState.all(
            const EdgeInsets.symmetric(
              vertical: Constant.minPadding * .5,
              horizontal: Constant.minPadding,
            ),
          ),
        ),
        child: const Text("Cancel"),
        onPressed: () {
          context.router.pop();
        },
      ),
    );
  }

  SizedBox _okButton(BuildContext context, ItemRowBlocState state) {
    return SizedBox(
      height: 30,
      child: CustomFilledButton(
        style: ButtonStyle(
          padding: ButtonState.all(
            const EdgeInsets.symmetric(
              vertical: Constant.minPadding * .5,
              horizontal: Constant.minPadding,
            ),
          ),
        ),
        onPressed: state.status.isValidated
            ? () {
                InventoryAdjustmentInRow data = InventoryAdjustmentInRow(
                  itemCode: state.itemCode.value,
                  itemDescription: _itemDescriptionController.text,
                  quantity: state.quantity.value!,
                  uom: state.uom.value,
                  whsecode: state.warehouse.value,
                );

                if (widget.invAdjInItemRow != null) {
                  widget.invAdjInBloc.add(
                    UpdateRowItem(
                      oldItem: widget.invAdjInItemRow!,
                      newItem: data,
                    ),
                  );
                } else {
                  widget.invAdjInBloc.add(AddRowItem(data));
                }
                context.router.pop();
              }
            : null,
        child: const Text("OK"),
      ),
    );
  }
}
