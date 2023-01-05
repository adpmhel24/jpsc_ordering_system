import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/src/data/models/models.dart';

import '../../../utils/currency_formater.dart';

class PriceQuotationCardItem extends StatelessWidget {
  PriceQuotationCardItem({
    Key? key,
    required this.pq,
  }) : super(key: key);

  final PriceQuotationModel pq;

  final DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ExpandablePanel(
          header: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WithLabel(
                labelText: 'Order ref:',
                textData: "${pq.reference}",
              ),
              const SizedBox(
                height: 5.0,
              ),
              WithLabel(
                labelText: 'Transaction date:',
                textData: dateFormat.format(DateTime.parse(pq.transdate!)),
              ),
              const SizedBox(
                height: 5.0,
              ),
              WithLabel(
                labelText: 'Card Code:',
                textData: "${pq.customerCode}",
              ),
              const SizedBox(
                height: 5.0,
              ),
              WithLabel(
                labelText: 'SQ Number:',
                textData: "${pq.sqNumber}",
              ),
              const SizedBox(
                height: 5.0,
              ),
              Wrap(
                spacing: 5.0,
                children: [
                  Text(
                    "Remarks:",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    "${pq.remarks}",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          collapsed: WithLabel(
            labelText: 'Subtotal:',
            textData: formatStringToDecimal("${pq.gross}"),
          ),
          expanded: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WithLabel(
                labelText: 'Subtotal:',
                textData: formatStringToDecimal("${pq.gross}"),
              ),
              const Divider(thickness: 2),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pq.rows!.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Text(
                          "${formatStringToDecimal('${pq.rows![index].quantity!}', decimalPlaces: 2)} ${pq.rows![index].uom!}"),
                      title: Text(pq.rows![index].itemCode!),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WithLabel(
                            labelText: "Act. Price:",
                            textData: formatStringToDecimal(
                                "${pq.rows![index].unitPrice!}"),
                          ),
                          WithLabel(
                            labelText: "Total:",
                            textData: formatStringToDecimal(
                                "${pq.rows![index].linetotal!}"),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  }),
              const Divider(thickness: 2),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 5.0,
                  children: [
                    Text(
                      "Subtotal:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 15.0),
                    ),
                    Text(
                      formatStringToDecimal("${pq.gross}"),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // tapHeaderToExpand: true,
          // hasIcon: true,
        ),
      ),
    );
  }
}

class WithLabel extends StatelessWidget {
  const WithLabel({
    Key? key,
    required this.labelText,
    required this.textData,
  }) : super(key: key);

  final String labelText;
  final String textData;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          textData,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
