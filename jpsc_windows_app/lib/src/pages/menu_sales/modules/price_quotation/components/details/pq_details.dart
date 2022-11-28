import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../data/models/models.dart';

import '../../../../../../global_blocs/bloc_price_quotation/details_pq_bloc/bloc.dart';
import '../../../../../../global_blocs/blocs.dart';
import '../../../../../../shared/widgets/bordered_text.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../utils/constant.dart';
import '../../../../../../utils/currency_formater.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../utils/responsive.dart';
import 'pq_details_table.dart';

class PriceQuotationHeaderDetailsPage extends StatelessWidget {
  const PriceQuotationHeaderDetailsPage({
    Key? key,
    @pathParam required this.id,
    @queryParam this.header = "",
    // required this.onRefresh,
  }) : super(key: key);

  final String header;
  final int id;
  // final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingPQDetailsBloc(
        context.read<PriceQuotationRepo>(),
      )..add(FetchedPQDetails(id)),
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
        content: BlocListener<FetchingPQDetailsBloc, FetchingPQDetailsState>(
          listener: (context, state) {
            if (state.status == FetchingStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == FetchingStatus.error) {
              context.loaderOverlay.hide();
              CustomDialogBox.errorMessage(context, message: state.message);
            } else if (state.status == FetchingStatus.success) {
              context.loaderOverlay.hide();
            }
          },
          child: BlocBuilder<FetchingPQDetailsBloc, FetchingPQDetailsState>(
            builder: (context, state) {
              if (state.status == FetchingStatus.success &&
                  state.data != null) {
                return PriceQuotationHeaderDetailsBody(
                  priceQuotation: state.data!,
                );
              }
              return const SizedBox.expand();
            },
          ),
        ),
      ),
    );
  }
}

class PriceQuotationHeaderDetailsBody extends StatefulWidget {
  const PriceQuotationHeaderDetailsBody(
      {Key? key, required this.priceQuotation})
      : super(key: key);

  final PriceQuotationModel priceQuotation;

  @override
  State<PriceQuotationHeaderDetailsBody> createState() =>
      _PriceQuotationHeaderDetailsBodyState();
}

class _PriceQuotationHeaderDetailsBodyState
    extends State<PriceQuotationHeaderDetailsBody> {
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);
  final ValueNotifier<List<PaymentTermModel>> _paymentTerms = ValueNotifier([]);
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _sqNumberController = TextEditingController();

  String? selectedBranch;
  String? selectedOrderStatus;
  String? selectedPaymentTerms;
  final List<String> _pqStatus = [
    "Price Confirmed",
    "With SAP SQ",
  ];

  late bool isDisable;

  @override
  void initState() {
    _remarksController.text = widget.priceQuotation.remarks ?? "";
    selectedBranch = widget.priceQuotation.dispatchingBranch;
    selectedPaymentTerms = widget.priceQuotation.paymentTerms;
    _sqNumberController.text = widget.priceQuotation.sqNumber?.toString() ?? "";
    selectedOrderStatus = widget.priceQuotation.pqStatus == 1
        ? "Price Confirmed"
        : widget.priceQuotation.pqStatus == 2
            ? "With SAP SQ"
            : null;

    // check if "C" or "N" contains the docstatus
    isDisable = "CN".contains(widget.priceQuotation.docstatus);

    _initialLoad();
    super.initState();
  }

  @override
  void dispose() {
    _branches.dispose();
    _sqNumberController.dispose();
    _remarksController.dispose();
    _paymentTerms.dispose();
    super.dispose();
  }

  void _initialLoad() async {
    context.loaderOverlay.show();
    try {
      final branchRepo = context.read<BranchRepo>();
      final payTermrepo = context.read<PaymentTermRepo>();
      await payTermrepo.getAll();
      await branchRepo.getAll();
      _branches.value = branchRepo.datas;
      _paymentTerms.value = payTermrepo.datas;
    } on HttpException catch (e) {
      CustomDialogBox.errorMessage(context, message: e.message);
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PriceQuotationUpdateBloc(
        salesOrdeRepo: context.read<PriceQuotationRepo>(),
        selectedPriceQuotation: PriceQuotationModel.fromJson(
          widget.priceQuotation.toJson(),
        ),
      ),
      child: BlocConsumer<PriceQuotationUpdateBloc, PriceQuotationUpdateState>(
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
                context.router.pop(); // To pop the Details Page.
              },
            );
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (_, constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(
                      mainAxisSize: Responsive.isMobile(context)
                          ? MainAxisSize.min
                          : MainAxisSize.max,
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
                                labeledCopyButton(
                                  label: "Reference :",
                                  value: widget.priceQuotation.reference,
                                ),
                                Constant.heightSpacer,
                                labeledCopyButton(
                                  label: "Posting Date :",
                                  value: dateFormatter(
                                      widget.priceQuotation.transdate),
                                ),
                                Constant.heightSpacer,
                                labeledCopyButton(
                                  label: "Delivery Date :",
                                  value: dateFormatter(
                                    widget.priceQuotation.deliveryDate,
                                    DateFormat(
                                      'MM/dd/yyyy',
                                    ),
                                  ),
                                ),
                                Constant.heightSpacer,
                                labeledCopyButton(
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
                                labeledWidget(
                                  label: "Dispatching Branch :",
                                  child:
                                      ValueListenableBuilder<List<BranchModel>>(
                                    valueListenable: _branches,
                                    builder: (context, datas, _) {
                                      return ComboBox<String>(
                                          value: selectedBranch,
                                          items: datas
                                              .map(
                                                (e) => ComboBoxItem(
                                                  value: e.code,
                                                  child:
                                                      Text(e.description ?? ""),
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
                                labeledWidget(
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
                                                .read<
                                                    PriceQuotationUpdateBloc>()
                                                .add(
                                                  OrderStatusChanged(pqStatus),
                                                );
                                          },
                                  ),
                                ),
                                Constant.heightSpacer,
                                labeledWidget(
                                  label: "Payment Terms:",
                                  child: ValueListenableBuilder<
                                      List<PaymentTermModel>>(
                                    valueListenable: _paymentTerms,
                                    builder: (context, datas, _) {
                                      return ComboBox<String>(
                                          value: selectedPaymentTerms,
                                          items: datas
                                              .map(
                                                (e) => ComboBoxItem(
                                                  value: e.code,
                                                  child:
                                                      Text(e.description ?? ""),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: isDisable
                                              ? null
                                              : (value) {
                                                  setState(() {
                                                    selectedPaymentTerms =
                                                        value;
                                                  });
                                                  context
                                                      .read<
                                                          PriceQuotationUpdateBloc>()
                                                      .add(
                                                        PaymentTermsChanged(
                                                            value ?? ""),
                                                      );
                                                });
                                    },
                                  ),
                                ),
                                Constant.heightSpacer,
                                labeledWidget(
                                  label: "SQ Number :",
                                  child: SizedBox(
                                    width: 150,
                                    child: TextBox(
                                      controller: _sqNumberController,
                                      enabled:
                                          selectedOrderStatus == 'With SAP SQ',
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
                    SizedBox(
                      height: 400,
                      child: DetailsTable(
                        itemRows: widget.priceQuotation.rows,
                      ),
                    ),
                    Constant.heightSpacer,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        labeledWidget(
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
                        labeledCopyButton(
                          label: "Subtotal :",
                          value: formatStringToDecimal(
                              "${state.priceQuotation.subtotal}"),
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
                ),
              );
            },
          );
        },
      ),
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
              color: Constant.overSRPColor,
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
              color: Constant.belowSRPColor,
            ),
            const Text("Below SRP")
          ],
        )
      ],
    );
  }

  SizedBox labeledCopyButton({required String label, required String value}) {
    return SizedBox(
      width: 200.0,
      child: InfoLabel(
        label: label,
        child: BorderedText(
          child: CopyButton(
            value: value,
          ),
        ),
      ),
    );
  }

  SizedBox labeledWidget({required String label, required Widget child}) {
    return SizedBox(
      width: 200.0,
      child: InfoLabel(
        label: label,
        child: child,
      ),
    );
  }
}
