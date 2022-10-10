import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/data/repositories/repos.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../widgets/custom_dropdown_search.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../../bloc/bloc.dart';

class CheckOutForm extends StatefulWidget {
  const CheckOutForm({Key? key}) : super(key: key);

  @override
  State<CheckOutForm> createState() => _CheckOutFormState();
}

class _CheckOutFormState extends State<CheckOutForm> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _orderNotes = TextEditingController();

  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  String? selectedDeliveryMethod;
  String? selectedPaymentTerm;

  List<String> deliveryMethods = ["Pickup", "Delivery"];

  final ValueNotifier<List<PaymentTermModel>> _terms = ValueNotifier([]);

  @override
  void initState() {
    fetchPaymentTerm();
    super.initState();
  }

  @override
  void dispose() {
    _orderNotes.dispose();
    _dateTimeController.dispose();
    _terms.dispose();
    super.dispose();
  }

  void fetchPaymentTerm() async {
    final repo = context.read<PaymentTermRepo>();
    await repo.getAll();
    _terms.value = repo.datas;
  }

  @override
  Widget build(BuildContext context) {
    CreatePriceQuotationBloc bloc = context.read<CreatePriceQuotationBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          MyCustomDropdownSearch<String>(
            labelText: "Delivery Method*",
            selectedItem: selectedDeliveryMethod,
            itemAsString: (data) => data!,
            items: deliveryMethods,
            compareFn: (data, selectedData) => data == selectedData,
            onChanged: (value) {
              bloc.add(DeliveryMethodChanged(value ?? ""));
            },
          ),
          Constant.heightSpacer,
          BlocBuilder<CreatePriceQuotationBloc, CreateSalesOrderState>(
            builder: (context, state) {
              selectedPaymentTerm = state.paymentTerm.value;
              return _paymentTermField(bloc);
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
                    .read<CreatePriceQuotationBloc>()
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

  ValueListenableBuilder<List<PaymentTermModel>> _paymentTermField(
      CreatePriceQuotationBloc bloc) {
    return ValueListenableBuilder<List<PaymentTermModel>>(
        valueListenable: _terms,
        builder: (_, terms, __) {
          return MyCustomDropdownSearch<String>(
            autoValidateMode: AutovalidateMode.always,
            labelText: "Payment Term",
            selectedItem: selectedPaymentTerm,
            itemAsString: (data) => data!,
            prefixIcon: const Icon(Icons.payment),
            items: terms.map((e) => e.code).toList(),
            compareFn: (data, selectedData) => data == selectedData,
            itemBuilder: (context, data, selected) => Card(
              elevation: 2,
              child: ListTile(
                selected: selected,
                title: Text(data),
              ),
            ),
            onChanged: (data) {
              selectedPaymentTerm = data;
              bloc.add(PaymentTermChanged(selectedPaymentTerm ?? ""));
            },
          );
        });
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
    CreatePriceQuotationBloc bloc = context.read<CreatePriceQuotationBloc>();
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
        bloc.add(RemarksChanged(value));
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
                .read<CreatePriceQuotationBloc>()
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
