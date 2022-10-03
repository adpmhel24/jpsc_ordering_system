import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/src/screens/modules/Sales_Order/create_sales_order/cart/components/cart_body.dart';
import 'package:uuid/uuid.dart';

import '../../../../widgets/custom_animated_dialog.dart';
import '../bloc/bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routeName = "CartRoute";

  @override
  Widget build(BuildContext context) {
    final uuid = const Uuid().v1();

    return Scaffold(
      body: const CartBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              50,
            ),
          )),
          onPressed:
              context.watch<CreateSalesOrderBloc>().state.status.isValidated
                  ? () {
                      CustomAnimatedDialog.warning(
                        cntx: context,
                        message: "Are you sure you want to proceed?",
                        onPositiveClick: (cntx) {
                          context
                              .read<CreateSalesOrderBloc>()
                              .add(OrderSubmitted(uuid));
                          Navigator.of(cntx).pop();
                        },
                      );
                    }
                  : null,
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
