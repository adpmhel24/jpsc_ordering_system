import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../data/models/models.dart';

import '../../../../../../global_blocs/bloc_sales_order/update_bloc/bloc.dart';
import '../../../../../../shared/widgets/bordered_text.dart';
import '../../../../../../shared/widgets/custom_filled_button.dart';
import '../../../../../../utils/constant.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../../widgets/custom_dialog.dart';
import 'so_details_table.dart';

class SalesOrderHeaderDetailsPage extends StatelessWidget {
  const SalesOrderHeaderDetailsPage({
    Key? key,
    required this.header,
    required this.salesOrder,
    required this.onRefresh,
  }) : super(key: key);

  final String header;
  final SalesOrderModel salesOrder;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => SalesOrderUpdateBloc(
        salesOrdeRepo: context.read<SalesOrderRepo>(),
        selectedSalesOrder: SalesOrderModel.fromJson(
          salesOrder.toJson(),
        ),
      ),
      child: ScaffoldPage.withPadding(
        header: PageHeader(
          leading: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.noWrap,
            primaryItems: [
              CommandBarBuilderItem(
                builder: (context, mode, w) => w,
                wrappedItem: CommandBarButton(
                  icon: const Icon(
                    FluentIcons.back,
                  ),
                  onPressed: () {
                    context.router.pop();
                  },
                ),
              ),
            ],
          ),
          title: Text(header),
        ),
        content: SalesOrderHeaderDetailsBody(
          salesOrder: salesOrder,
          onRefresh: onRefresh,
        ),
      ),
    );
  }
}

class SalesOrderHeaderDetailsBody extends StatefulWidget {
  const SalesOrderHeaderDetailsBody(
      {Key? key, required this.salesOrder, required this.onRefresh})
      : super(key: key);

  final SalesOrderModel salesOrder;
  final void Function() onRefresh;

  @override
  State<SalesOrderHeaderDetailsBody> createState() =>
      _SalesOrderHeaderDetailsBodyState();
}

class _SalesOrderHeaderDetailsBodyState
    extends State<SalesOrderHeaderDetailsBody> {
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);
  final TextEditingController _remarksController = TextEditingController();

  String? selectedBranch;
  String? selectedOrderStatus;
  final List<String> _orderStatus = [
    "Price Confirmed",
    "Credit Confirmed",
    "Dispatched"
  ];

  late bool isDisable;

  @override
  void initState() {
    _remarksController.text = widget.salesOrder.remarks ?? "";
    selectedBranch = widget.salesOrder.dispatchingBranch;
    selectedOrderStatus = widget.salesOrder.orderStatus == 1
        ? "Price Confirmed"
        : widget.salesOrder.orderStatus == 2
            ? "Credit Confirmed"
            : widget.salesOrder.orderStatus == 3
                ? "Dispatched"
                : null;

    // check if "C" or "N" contains the docstatus
    isDisable = "CN".contains(widget.salesOrder.docstatus);
    _fetchBranchForDispatch();
    super.initState();
  }

  @override
  void dispose() {
    _branches.dispose();
    _remarksController.dispose();

    super.dispose();
  }

  void _fetchBranchForDispatch() async {
    final branchRepo = context.read<BranchRepo>();
    await branchRepo.getAll();
    _branches.value = branchRepo.datas;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesOrderUpdateBloc, SalesOrderUpdateState>(
      buildWhen: (prev, curr) {
        return prev != curr;
      },
      listener: (_, state) {
        if (state.status == FetchingStatus.loading) {
          context.loaderOverlay.show();
        } else if (state.status == FetchingStatus.error) {
          context.loaderOverlay.hide();
          CustomDialogBox.errorMessage(context, message: state.message);
        } else if (state.status == FetchingStatus.success) {
          context.loaderOverlay.hide();
          CustomDialogBox.successMessage(
            context,
            message: state.message,
            onPositiveClick: (cntx) {
              widget.onRefresh();
              cntx.router.pop(); // To pop the Dialog box.
              context.router.pop(); // To pop the Details Page.
            },
          );
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: constraints.maxWidth * .5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            wrapLabelSelectableText(
                              label: "Reference :",
                              value: widget.salesOrder.reference,
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Posting Date :",
                              value: dateFormatter(widget.salesOrder.transdate),
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Delivery Date :",
                              value: dateFormatter(
                                widget.salesOrder.deliveryDate,
                                DateFormat(
                                  'MM/dd/yyyy',
                                ),
                              ),
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Customer Code :",
                              value: widget.salesOrder.customerCode,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: constraints.maxWidth * .5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _wrapLabelWidget(
                              label: "Dispatching Branch :",
                              child: ValueListenableBuilder<List<BranchModel>>(
                                valueListenable: _branches,
                                builder: (context, datas, _) {
                                  return ComboBox<String>(
                                      value: selectedBranch,
                                      items: datas
                                          .map(
                                            (e) => ComboBoxItem(
                                              value: e.code,
                                              child: Text(e.description ?? ""),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: isDisable
                                          ? null
                                          : (value) {
                                              setState(() {
                                                selectedBranch = value;
                                              });
                                              context
                                                  .read<SalesOrderUpdateBloc>()
                                                  .add(
                                                    DispatchBranchChanged(
                                                        value ?? ""),
                                                  );
                                            });
                                },
                              ),
                            ),
                            Constant.heightSpacer,
                            _wrapLabelWidget(
                              label: "Order Status :",
                              child: ComboBox<String>(
                                value: selectedOrderStatus,
                                items: _orderStatus
                                    .map(
                                      (e) => ComboBoxItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: isDisable
                                    ? null
                                    : (value) {
                                        int orderStatus = 0;
                                        if (value == "Price Confirmed") {
                                          orderStatus = 1;
                                        }
                                        if (value == "Credit Confirmed") {
                                          orderStatus = 2;
                                        }
                                        if (value == "Dispatched") {
                                          orderStatus = 3;
                                        }
                                        setState(() {
                                          selectedOrderStatus = value;
                                        });
                                        context
                                            .read<SalesOrderUpdateBloc>()
                                            .add(
                                              OrderStatusChanged(orderStatus),
                                            );
                                      },
                              ),
                            ),
                            Constant.heightSpacer,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Constant.heightSpacer,
                Expanded(
                  child: DetailsTable(
                    itemRows: widget.salesOrder.rows,
                  ),
                ),
                Constant.heightSpacer,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _wrapLabelWidget(
                      label: "Remarks: ",
                      child: SizedBox(
                        width: constraints.maxHeight * .5,
                        child: TextFormBox(
                          controller: _remarksController,
                          minLines: 2,
                          maxLines: 5,
                          onChanged: (val) {
                            context.read<SalesOrderUpdateBloc>().add(
                                  SalesOrderRemarksChanged(
                                      _remarksController.text),
                                );
                          },
                        ),
                      ),
                    ),
                    wrapLabelSelectableText(
                      label: "Subtotal :",
                      value: "${state.salesOrder.subtotal}",
                    ),
                  ],
                ),
                Constant.heightSpacer,
                SizedBox(
                  width: 100,
                  height: 30,
                  child: CustomFilledButton(
                    onPressed: () {
                      CustomDialogBox.warningMessage(context,
                          message:
                              "Are you sure you want to update this transaction?",
                          onPositiveClick: (cntx) {
                        context.read<SalesOrderUpdateBloc>().add(
                              SalesOrderUpdateSubmitted(),
                            );
                        cntx.router.pop();
                      });
                    },
                    child: const Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Wrap wrapLabelSelectableText({required String label, required String value}) {
    return Wrap(
      spacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label),
        BorderedText(
          child: SelectableText(
            value,
            toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
          ),
        ),
      ],
    );
  }

  Wrap _wrapLabelWidget({required String label, required Widget child}) {
    return Wrap(
      spacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label),
        child,
      ],
    );
  }
}
