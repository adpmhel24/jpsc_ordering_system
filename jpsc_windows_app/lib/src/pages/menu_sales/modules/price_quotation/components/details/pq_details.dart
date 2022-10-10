import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../data/models/models.dart';

import '../../../../../../global_blocs/blocs.dart';
import '../../../../../../shared/widgets/bordered_text.dart';
import '../../../../../../shared/widgets/custom_filled_button.dart';
import '../../../../../../utils/constant.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../../widgets/custom_dialog.dart';
import 'pq_details_table.dart';

class PriceQuotationHeaderDetailsPage extends StatelessWidget {
  const PriceQuotationHeaderDetailsPage({
    Key? key,
    required this.header,
    required this.priceQuotation,
    required this.onRefresh,
  }) : super(key: key);

  final String header;
  final PriceQuotationModel priceQuotation;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => PriceQuotationUpdateBloc(
        salesOrdeRepo: context.read<PriceQuotationRepo>(),
        selectedPriceQuotation: PriceQuotationModel.fromJson(
          priceQuotation.toJson(),
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
        content: PriceQuotationHeaderDetailsBody(
          priceQuotation: priceQuotation,
          onRefresh: onRefresh,
        ),
      ),
    );
  }
}

class PriceQuotationHeaderDetailsBody extends StatefulWidget {
  const PriceQuotationHeaderDetailsBody(
      {Key? key, required this.priceQuotation, required this.onRefresh})
      : super(key: key);

  final PriceQuotationModel priceQuotation;
  final void Function() onRefresh;

  @override
  State<PriceQuotationHeaderDetailsBody> createState() =>
      _PriceQuotationHeaderDetailsBodyState();
}

class _PriceQuotationHeaderDetailsBodyState
    extends State<PriceQuotationHeaderDetailsBody> {
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _sqNumberController = TextEditingController();

  String? selectedBranch;
  String? selectedOrderStatus;
  final List<String> _pqStatus = [
    "Price Confirmed",
    "With SAP SQ",
  ];

  late bool isDisable;

  @override
  void initState() {
    _remarksController.text = widget.priceQuotation.remarks ?? "";
    selectedBranch = widget.priceQuotation.dispatchingBranch;
    _sqNumberController.text = widget.priceQuotation.sqNumber?.toString() ?? "";
    selectedOrderStatus = widget.priceQuotation.pqStatus == 1
        ? "Price Confirmed"
        : widget.priceQuotation.pqStatus == 2
            ? "With SAP SQ"
            : null;

    // check if "C" or "N" contains the docstatus
    isDisable = "CN".contains(widget.priceQuotation.docstatus);
    _fetchBranchForDispatch();
    super.initState();
  }

  @override
  void dispose() {
    _branches.dispose();
    _sqNumberController.dispose();
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
    return BlocConsumer<PriceQuotationUpdateBloc, PriceQuotationUpdateState>(
      buildWhen: (prev, curr) {
        return prev != curr;
      },
      listenWhen: (prev, curr) => prev.status != curr.status,
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
                              value: widget.priceQuotation.reference,
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Posting Date :",
                              value: dateFormatter(
                                  widget.priceQuotation.transdate),
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Delivery Date :",
                              value: dateFormatter(
                                widget.priceQuotation.deliveryDate,
                                DateFormat(
                                  'MM/dd/yyyy',
                                ),
                              ),
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Customer Code :",
                              value: widget.priceQuotation.customerCode,
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
                                                  .read<
                                                      PriceQuotationUpdateBloc>()
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
                              label: "PQ Status :",
                              child: ComboBox<String>(
                                value: selectedOrderStatus,
                                items: _pqStatus
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
                                        int pqStatus = 0;
                                        if (value == "Price Confirmed") {
                                          pqStatus = 1;
                                        }
                                        if (value == "With SAP SQ") {
                                          pqStatus = 2;
                                        }
                                        setState(() {
                                          selectedOrderStatus = value;
                                        });
                                        context
                                            .read<PriceQuotationUpdateBloc>()
                                            .add(
                                              OrderStatusChanged(pqStatus),
                                            );
                                      },
                              ),
                            ),
                            Constant.heightSpacer,
                            wrapLabelSelectableText(
                              label: "Payment Term :",
                              value: widget.priceQuotation.paymentTerm ?? "",
                            ),
                            Constant.heightSpacer,
                            _wrapLabelWidget(
                              label: "SQ Number :",
                              child: SizedBox(
                                width: 150,
                                child: TextBox(
                                  controller: _sqNumberController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+')),
                                  ],
                                  onChanged: (v) {
                                    context
                                        .read<PriceQuotationUpdateBloc>()
                                        .add(
                                          SQNumberChanged(int.tryParse(v)),
                                        );
                                  },
                                ),
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
                legends(),
                Constant.heightSpacer,
                Expanded(
                  child: DetailsTable(
                    itemRows: widget.priceQuotation.rows,
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
                            context.read<PriceQuotationUpdateBloc>().add(
                                  PriceQuotationRemarksChanged(
                                      _remarksController.text),
                                );
                          },
                        ),
                      ),
                    ),
                    wrapLabelSelectableText(
                      label: "Subtotal :",
                      value: "${state.priceQuotation.subtotal}",
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
                        context.read<PriceQuotationUpdateBloc>().add(
                              PriceQuotationUpdateSubmitted(),
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

  Row legends() {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              color: const Color(0xFFA8E890),
            ),
            const Text("Over SRP")
          ],
        ),
        Constant.widthSpacer,
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              color: const Color(0xFFC8DBBE),
            ),
            const Text("Below SRP")
          ],
        )
      ],
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