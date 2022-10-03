import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_blocs/bloc_sales_order/cancel_sales_order/bloc.dart';
import '../../../../global_blocs/bloc_sales_order/fetching_sales_order/bloc.dart';
import '../../../../shared/widgets/custom_date_picker.dart';
import '../../../../utils/constant.dart';

import '../../../../utils/fetching_status.dart';
import '../../../widgets/custom_dialog.dart';
import 'widgets/sales_order_table.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesOrderPage> createState() => _SalesOrderPageState();
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();
  final TextEditingController _searchBoxController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  String docStatus = "O";

  // 0 for price confirmations
  // 1 for credit confirmation
  // 2 dispatched
  int orderStatus = 0;

  int currentIndex = 0;

  @override
  void dispose() {
    _searchBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FetchingSalesOrderHeaderBloc(
            context.read<SalesOrderRepo>(),
          ),
        ),
        BlocProvider(
          create: (_) => SalesOrderCancelBloc(
            context.read<SalesOrderRepo>(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SalesOrderCancelBloc, SalesOrderCancelState>(
            listener: (context, state) {
              if (state.status == FetchingStatus.loading) {
                context.loaderOverlay.show();
              } else if (state.status == FetchingStatus.error) {
                context.loaderOverlay.hide();
                CustomDialogBox.errorMessage(context, message: state.message);
              } else if (state.status == FetchingStatus.success) {
                context.loaderOverlay.hide();
                CustomDialogBox.successMessage(context, message: state.message,
                    onPositiveClick: (cntx) {
                  cntx.router.pop(); // to pop the dialogbox
                  sfDataGridKey.currentState!.refresh();
                });
              }
            },
          ),
          BlocListener<FetchingSalesOrderHeaderBloc,
              FetchingSalesOrderHeaderState>(
            listener: (_, state) {
              if (state.status == FetchingStatus.loading) {
                context.loaderOverlay.show();
              } else if (state.status == FetchingStatus.error) {
                context.loaderOverlay.hide();
                CustomDialogBox.errorMessage(context, message: state.message);
              } else if (state.status == FetchingStatus.success) {
                context.loaderOverlay.hide();
              }
            },
          ),
        ],
        child: ScaffoldPage.withPadding(
          header: _header(context),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flex(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.horizontal,
                children: [
                  _searchBox(),
                  const Spacer(),
                  _fromDatePicker(),
                  Constant.widthSpacer,
                  _toDatePicker(),
                ],
              ),
              Constant.heightSpacer,
              _commandBar(),
              Constant.heightSpacer,
              Expanded(
                child: TabView(
                  tabWidthBehavior: TabWidthBehavior.sizeToContent,
                  currentIndex: currentIndex,
                  closeButtonVisibility: CloseButtonVisibilityMode.never,
                  onChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      orderStatus = index;
                      if (index == 0 || index == 1 || index == 2) {
                        fromDate = null;
                        toDate = null;
                      } else {
                        fromDate = DateTime.now();
                        toDate = DateTime.now();
                      }
                    });
                  },
                  tabs: [
                    Tab(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/done_document.png'),
                      ),
                      text: Text(
                        "For Price Confirmation",
                        style: (currentIndex == 0)
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.teal.lightest)
                            : null,
                      ),
                      body: SalesOrderHeaderTable(
                        sfDataGridKey: sfDataGridKey,
                        docStatus: docStatus,
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            toDate == null ? "" : dateFormat.format(toDate!),
                        orderStatus: orderStatus,
                      ),
                    ),
                    Tab(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/done_document.png'),
                      ),
                      text: Text(
                        "For Credit Confirmation",
                        style: (currentIndex == 1)
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.teal.lightest)
                            : null,
                      ),
                      body: SalesOrderHeaderTable(
                        sfDataGridKey: sfDataGridKey,
                        docStatus: docStatus,
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            toDate == null ? "" : dateFormat.format(toDate!),
                        orderStatus: orderStatus,
                      ),
                    ),
                    Tab(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/done_document.png'),
                      ),
                      text: Text(
                        "For Dispatch",
                        style: (currentIndex == 2)
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.teal.lightest)
                            : null,
                      ),
                      body: SalesOrderHeaderTable(
                        sfDataGridKey: sfDataGridKey,
                        docStatus: docStatus,
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            toDate == null ? "" : dateFormat.format(toDate!),
                        orderStatus: orderStatus,
                      ),
                    ),
                    Tab(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/done_document.png'),
                      ),
                      text: Text(
                        "Dispatched",
                        style: (currentIndex == 3)
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.teal.lightest)
                            : null,
                      ),
                      body: SalesOrderHeaderTable(
                        sfDataGridKey: sfDataGridKey,
                        docStatus: "C",
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            toDate == null ? "" : dateFormat.format(toDate!),
                        orderStatus: orderStatus,
                      ),
                    ),
                    Tab(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/done_document.png'),
                      ),
                      text: Text(
                        "Canceled",
                        style: (currentIndex == 4)
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.teal.lightest)
                            : null,
                      ),
                      body: SalesOrderHeaderTable(
                        sfDataGridKey: sfDataGridKey,
                        docStatus: "N",
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            toDate == null ? "" : dateFormat.format(toDate!),
                        orderStatus: null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CommandBarCard _commandBar() {
    return CommandBarCard(
      child: CommandBar(
        overflowBehavior: CommandBarOverflowBehavior.clip,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.add),
              label: const Text("New"),
              onPressed: () {},
            ),
          ),
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.refresh),
              label: const Text("Refresh"),
              onPressed: () {
                sfDataGridKey.currentState!.refresh();
              },
            ),
          ),
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.filter),
              label: const Text("Filter"),
              onPressed: () {
                context.read<FetchingSalesOrderHeaderBloc>().add(
                      FetchAllSalesOrderHeader(
                        docStatus: docStatus,
                        orderStatus: orderStatus,
                        fromDate: fromDate == null
                            ? ""
                            : dateFormat.format(fromDate!),
                        toDate:
                            fromDate == null ? "" : dateFormat.format(toDate!),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  CustomDatePicker _toDatePicker() {
    return CustomDatePicker(
      label: "To Date",
      date: toDate,
      isRemoveShow: true,
      dateFormat: dateFormat,
      onChanged: (dateTime) {
        setState(() {
          toDate = dateTime;
        });
      },
    );
  }

  CustomDatePicker _fromDatePicker() {
    return CustomDatePicker(
      label: "From Date",
      date: fromDate,
      isRemoveShow: true,
      dateFormat: dateFormat,
      onChanged: (dateTime) {
        setState(() {
          fromDate = dateTime;
        });
      },
    );
  }

  SizedBox _searchBox() {
    return SizedBox(
      width: 200,
      child: TextBox(
        header: "Search",
        controller: _searchBoxController,
        suffix: const Icon(FluentIcons.search),
        placeholder: 'Type to filter the table',
      ),
    );
  }

  PageHeader _header(BuildContext context) {
    return PageHeader(
      leading: CommandBar(
        overflowBehavior: CommandBarOverflowBehavior.noWrap,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.back),
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
        ],
      ),
      title: const Text("Sales Order"),
    );
  }
}
