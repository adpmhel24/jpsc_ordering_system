import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/screens/modules/Sales_Order/create_sales_order/bloc/bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/currency_formater.dart';

class DismissibleCart extends StatelessWidget {
  const DismissibleCart({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Dismissible(
      key: Key(cartItem.id.toString()),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CreateSalesOrderBloc>().add(CartItemDeleted(cartItem));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ((screenWidth - 10) * .25),
                child: Text(cartItem.itemCode),
              ),
              Constant.heightSpacer,
              SizedBox(
                width: ((screenWidth - 10) * .35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quanity: ${formatStringToDecimal(
                        cartItem.quantity.toString(),
                        hasCurrency: false,
                      )}",
                      textAlign: TextAlign.center,
                    ),
                    Constant.heightSpacer,
                    Text(
                      "SRP Price: ${formatStringToDecimal(
                        cartItem.srpPrice.toString(),
                        hasCurrency: false,
                      )}",
                      textAlign: TextAlign.center,
                    ),
                    Constant.heightSpacer,
                    Text(
                      "Actual Price: ${formatStringToDecimal(
                        cartItem.unitPrice.toString(),
                        hasCurrency: false,
                      )}",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Constant.heightSpacer,
              SizedBox(
                width: ((screenWidth - 10) * .20),
                child: Text(
                  formatStringToDecimal(
                    cartItem.total.toString(),
                    hasCurrency: false,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
