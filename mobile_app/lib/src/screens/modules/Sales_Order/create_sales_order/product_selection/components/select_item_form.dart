import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../bloc/bloc.dart';

class SelectItemForm extends StatefulWidget {
  final ProductModel product;
  final CreateSalesOrderBloc createSalesOrderBloc;

  const SelectItemForm({
    Key? key,
    required this.product,
    required this.createSalesOrderBloc,
  }) : super(key: key);

  @override
  State<SelectItemForm> createState() => _SelectItemFormState();
}

class _SelectItemFormState extends State<SelectItemForm> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _actualPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _uomController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  var uuid = const Uuid();

  final ValueNotifier<Map<String, dynamic>> validValues =
      ValueNotifier({"isActualPriceValid": true, "isQuantityValid": true});

  @override
  void initState() {
    _quantityController.text = '1.00';
    _unitPriceController.text =
        widget.product.price?.toStringAsFixed(2) ?? "0.00";
    _actualPriceController.text =
        widget.product.price?.toStringAsFixed(2) ?? "0.00";
    _itemNameController.text = widget.product.code;
    _totalController.text = widget.product.price?.toStringAsFixed(2) ?? "0.00";
    _uomController.text = widget.product.saleUomCode ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalController.dispose();
    _uomController.dispose();
    _actualPriceController.dispose();

    super.dispose();
  }

  Map<String, dynamic> data = {};

  void _onQuantityChanged(value) {
    double total =
        double.parse(_actualPriceController.text) * double.parse(value);
    setState(() {
      _totalController.text = total.toStringAsFixed(2);
    });
  }

  void _onActualPriceChanged(value) {
    double total = double.parse(_quantityController.text) * double.parse(value);
    setState(() {
      _totalController.text = total.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: 'Item Name',
                controller: _itemNameController,
                readOnly: true,
                enabled: false,
                prefixIcon: const Icon(LineIcons.shoppingBasket),
              ),
              Constant.heightSpacer,
              Row(
                children: [
                  Flexible(
                    child: _quantityField(),
                  ),
                  Constant.widthSpacer,
                  Flexible(
                    child: _uomField(),
                  ),
                ],
              ),
              Constant.heightSpacer,
              Row(
                children: [
                  Flexible(
                    child: _unitPriceField(),
                  ),
                  Constant.widthSpacer,
                  Flexible(
                    child: _actualPriceField(),
                  ),
                ],
              ),
              Constant.heightSpacer,
              _totalAmountField(),
              Constant.heightSpacer,
              ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: validValues,
                  builder: (_, data, wt) {
                    return ElevatedButton(
                      onPressed: data["isActualPriceValid"] &&
                              data["isQuantityValid"]
                          ? () {
                              CustomAnimatedDialog.warning(
                                  cntx: context,
                                  message: "Are you sure you want to proceed?",
                                  onPositiveClick: (cntx) {
                                    widget.createSalesOrderBloc.add(
                                      CartItemAdded(
                                        CartItemModel(
                                          id: uuid.v1(),
                                          itemCode: _itemNameController.text,
                                          quantity: double.parse(
                                              _quantityController.text),
                                          srpPrice: double.parse(
                                              _unitPriceController.text),
                                          unitPrice: double.parse(
                                              _actualPriceController.text),
                                          uom: _uomController.text,
                                          total: double.parse(
                                            _totalController.text,
                                          ),
                                        ),
                                      ),
                                    );

                                    // to pop the dialog warning
                                    Navigator.of(cntx).pop();

                                    // to pop the Modal
                                    Navigator.of(context).pop();

                                    Fluttertoast.showToast(
                                        msg: "Item Added",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                            }
                          : null,
                      child: const Text('Add To Cart'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _quantityField() {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      labelText: 'Quantity *',
      controller: _quantityController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      prefixIcon: const Icon(LineIcons.addToShoppingCart),
      onChanged: (value) {
        String quantity = value.isEmpty ? "0" : value;
        validValues.value["isQuantityValid"] = value.isNotEmpty;
        _onQuantityChanged(quantity);
      },
      validator: (value) => value!.isNotEmpty ? null : "Required field!",
    );
  }

  _unitPriceField() {
    return CustomTextField(
      labelText: 'Unit Price',
      readOnly: true,
      enabled: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _unitPriceController,
      prefixIcon: const Icon(LineIcons.tags),
    );
  }

  _actualPriceField() {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      controller: _actualPriceController,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      labelText: 'Actual Price *',
      prefixIcon: const Icon(Icons.price_change),
      onChanged: (value) {
        String actualPrice = value.isEmpty ? "0" : value;
        validValues.value["isActualPriceValid"] = value.isNotEmpty;
        _onActualPriceChanged(actualPrice);
      },
      validator: (value) => value!.isNotEmpty ? null : "Required field!",
    );
  }

  _uomField() {
    return CustomTextField(
      controller: _uomController,
      readOnly: true,
      labelText: 'UoM',
      enabled: false,
      prefixIcon: const Icon(
        Icons.scale,
      ),
    );
  }

  _totalAmountField() {
    return CustomTextField(
      controller: _totalController,
      readOnly: true,
      labelText: 'Total Amount',
      enabled: false,
      prefixIcon: const Icon(
        Icons.money,
      ),
    );
  }
}
