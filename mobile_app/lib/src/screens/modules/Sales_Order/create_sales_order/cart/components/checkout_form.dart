import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/screens/modules/Sales_Order/create_sales_order/bloc/bloc.dart';

import '../../../../../utils/constant.dart';
import '../../../../../widgets/custom_dropdown_search.dart';
import '../../../../../widgets/custom_text_field.dart';

class CheckOutForm extends StatefulWidget {
  const CheckOutForm({Key? key}) : super(key: key);

  @override
  State<CheckOutForm> createState() => _CheckOutFormState();
}

class _CheckOutFormState extends State<CheckOutForm> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();
  final TextEditingController _paymentTermController = TextEditingController();

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  String? selectedDeliveryMethod;
  String? selectedPaymentMethod;

  List<String> deliveryMethods = ["Pickup", "Delivery"];

  List<String> paymentMethods = [
    'Cash On Delivery',
    'OnlineBanking',
    'GCash',
    'PayMaya',
  ];

  @override
  void dispose() {
    _orderNotes.dispose();
    _dateTimeController.dispose();
    _paymentTermController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CreateSalesOrderBloc createSalesOrderBloc =
        context.read<CreateSalesOrderBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          MyCustomDropdownSearch<String>(
            labelText: "Delivery Method",
            selectedItem: selectedDeliveryMethod,
            itemAsString: (data) => data!,
            items: deliveryMethods,
            compareFn: (data, selectedData) => data == selectedData,
            onChanged: (value) {
              createSalesOrderBloc.add(DeliveryMethodChanged(value ?? ""));
            },
          ),
          Constant.heightSpacer,
          BlocBuilder<CreateSalesOrderBloc, CreateSalesOrderState>(
            builder: (context, state) {
              _paymentTermController.text = state.paymentTerm.value;
              return CustomTextField(
                enabled: false,
                labelText: "Payment Term",
                controller: _paymentTermController,
              );
            },
          ),
          Constant.heightSpacer,
          DeliveryDateField(
            controller: _dateTimeController,
            dateFormat: dateFormat,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _dateTimeController.clear();
                context
                    .read<CreateSalesOrderBloc>()
                    .add(const DeliveryDateChanged(""));
              },
            ),
          ),
          Constant.heightSpacer,
          RemarksField(
            controller: _orderNotes,
          ),
        ],
      ),
    );
  }
}

class RemarksField extends StatelessWidget {
  final TextEditingController _controller;

  const RemarksField({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    CreateSalesOrderBloc createSalesOrderBloc =
        context.read<CreateSalesOrderBloc>();
    return CustomTextField(
      textInputAction: TextInputAction.newline,
      controller: _controller,
      labelText: 'Order Notes',
      minLines: 3,
      maxLines: 6,
      textAlign: TextAlign.left,
      prefixIcon: const Icon(Icons.note_add),
      suffixIcon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _controller.clear();
        },
      ),
      onChanged: (value) {
        createSalesOrderBloc.add(RemarksChanged(value));
      },
    );
  }
}

class DeliveryDateField extends StatelessWidget {
  final TextEditingController _controller;
  final DateFormat _dateFormat;
  final Widget? _suffixIcon;

  const DeliveryDateField({
    Key? key,
    required TextEditingController controller,
    required DateFormat dateFormat,
    Widget? suffixIcon,
  })  : _controller = controller,
        _dateFormat = dateFormat,
        _suffixIcon = suffixIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      controller: _controller,
      labelText: 'Delivery Date*',
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2100, 12, 31),
          onConfirm: (date) {
            _controller.text = _dateFormat.format(date);
            context
                .read<CreateSalesOrderBloc>()
                .add(DeliveryDateChanged(date.toIso8601String()));
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      prefixIcon: const Icon(Icons.calendar_today),
      suffixIcon: _suffixIcon,
    );
  }
}
