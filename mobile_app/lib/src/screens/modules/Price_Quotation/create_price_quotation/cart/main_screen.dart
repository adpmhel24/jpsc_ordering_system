import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

import '../../../../widgets/custom_animated_dialog.dart';
import '../bloc/bloc.dart';
import 'components/cart_body.dart';

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
              context.watch<CreatePriceQuotationBloc>().state.status.isValidated
                  ? () {
                      CustomAnimatedDialog.warning(
                        context,
                        message: "Are you sure you want to proceed?",
                        onPositiveClick: (cntx) {
                          context
                              .read<CreatePriceQuotationBloc>()
                              .add(OrderSubmitted(uuid));
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
