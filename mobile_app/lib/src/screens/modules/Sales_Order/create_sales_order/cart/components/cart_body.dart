import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constant.dart';
import '../../../../../utils/currency_formater.dart';
import '../../bloc/bloc.dart';
import 'checkout_form.dart';
import 'dismissible_cart.dart';

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CreateSalesOrderBloc, CreateSalesOrderState>(
        builder: (_, state) {
          return Column(
            children: [
              Constant.heightSpacer,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.cartItems.value.length,
                itemBuilder: (context, index) {
                  return DismissibleCart(
                      cartItem: state.cartItems.value[index]);
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              CartTotalDetails(
                createSalesOrderState: state,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              Constant.heightSpacer,
              Text(
                "Other Details",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Constant.heightSpacer,
              const CheckOutForm(),
            ],
          );
        },
      ),
    );
  }
}

class CartTotalDetails extends StatelessWidget {
  const CartTotalDetails({Key? key, required this.createSalesOrderState})
      : super(key: key);

  final CreateSalesOrderState createSalesOrderState;

  @override
  Widget build(BuildContext context) {
    List<double> totalOrders = createSalesOrderState.cartItems.valid
        ? createSalesOrderState.cartItems.value.map((e) => e.total).toList()
        : [];
    final totalOrder = totalOrders.fold<double>(0, (p, c) => p + c);
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customLabel(labelText: 'Total Order:'),
              Constant.widthSpacer,
              dataContainerHolder(
                textData: totalOrder.toStringAsFixed(3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  customLabel({
    required String labelText,
    TextStyle? style,
  }) {
    return SizedBox(
      width: 150,
      child: Text(
        labelText,
        style: style ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
      ),
    );
  }

  dataContainerHolder({required String textData}) {
    return SizedBox(
      width: 100,
      child: Text(
        formatStringToDecimal(
          textData,
          hasCurrency: true,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
