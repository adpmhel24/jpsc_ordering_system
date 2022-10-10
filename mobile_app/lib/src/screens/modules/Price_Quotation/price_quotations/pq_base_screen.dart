import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../../utils/constant.dart';
import '../../../widgets/custom_date_field.dart';
import 'bloc/bloc.dart';
import 'card_item.dart';

class PurchaseQuotationsBaseScreen extends StatefulWidget {
  const PurchaseQuotationsBaseScreen({
    Key? key,
    required this.startdateController,
    required this.enddateController,
    this.pqStatus,
    required this.docStatus,
  }) : super(key: key);

  final TextEditingController startdateController;
  final TextEditingController enddateController;
  final int? pqStatus;
  final String docStatus;

  @override
  State<PurchaseQuotationsBaseScreen> createState() =>
      _PurchaseQuotationsBaseScreenState();
}

class _PurchaseQuotationsBaseScreenState
    extends State<PurchaseQuotationsBaseScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      context.read<PriceQuotationsBloc>().add(
            FetchPriceQuotation(
              fromDate: widget.startdateController.text,
              toDate: widget.enddateController.text,
              pqStatus: widget.pqStatus,
              docStatus: widget.docStatus,
            ),
          );
    }
  }

  TextEditingController startDate = TextEditingController();
  final DateFormat dateFormat = DateFormat("MM/dd/yy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: CustomDateField(
                  labelText: "Start Date",
                  controller: widget.startdateController,
                  dateFormat: dateFormat,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      widget.startdateController.clear();
                    },
                    splashRadius: 15,
                  ),
                ),
              ),
              Constant.widthSpacer,
              Flexible(
                child: CustomDateField(
                  labelText: "End Date",
                  controller: widget.enddateController,
                  dateFormat: dateFormat,
                  suffixIcon: IconButton(
                    splashRadius: 15,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      widget.enddateController.clear();
                    },
                  ),
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  _refresh(context);
                },
                icon: const Icon(
                  Icons.search_sharp,
                ),
              ),
            ],
          ),
          Constant.heightSpacer,
          Expanded(
            child: BlocBuilder<PriceQuotationsBloc, PriceQuotationsState>(
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ListView.builder(
                    itemCount: state.datas.length,
                    itemBuilder: (cntxt, i) {
                      return PriceQuotationCardItem(
                        pq: state.datas[i],
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
