import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../utils/currency_formater.dart';
import '../../bloc/bloc.dart';
import 'select_item_form.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 93, 50, 50)
              : const Color(0xFFFFCBCB),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price : ${formatStringToDecimal(product.price!.toStringAsFixed(2))}',
              ),
            ],
          ),
        ),
        child: GestureDetector(
          onTap: () {
            _showButtonSheet(context);
          },
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade600
                : const Color(0xFFE7FBBE),
            child: Text(
              product.code,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  _showButtonSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (_) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: SelectItemForm(
          product: product,
          bloc: context.read<CreatePriceQuotationBloc>(),
        ),
      ),
    );
  }
}
