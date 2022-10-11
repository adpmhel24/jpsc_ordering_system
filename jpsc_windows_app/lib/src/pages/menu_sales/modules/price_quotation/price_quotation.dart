import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_blocs/blocs.dart';
import '../../../../shared/widgets/custom_date_picker.dart';
import '../../../../utils/constant.dart';

import '../../../../utils/fetching_status.dart';
import '../../../widgets/custom_dialog.dart';
import 'components/pq_table.dart';

class PriceQuotationPage extends StatefulWidget {
  const PriceQuotationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PriceQuotationPage> createState() => _PriceQuotationPageState();
}

class _PriceQuotationPageState extends State<PriceQuotationPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  DateTime? fromDate;
  DateTime? toDate;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  String docStatus = "O";

  // 0 for price confirmations
  // 1 for credit confirmation
  // 2 dispatched
  int? pqStatus = 0;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FetchingPriceQuotationHeaderBloc(
            context.read<PriceQuotationRepo>(),
          )..add(
              FetchAllPriceQuotationHeader(
                docStatus: docStatus,
                pqStatus: pqStatus,
                fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
                toDate: toDate == null ? "" : dateFormat.format(toDate!),
              ),
            ),
        ),
        BlocProvider(
          create: (_) => PriceQuotationCancelBloc(
            context.read<PriceQuotationRepo>(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PriceQuotationCancelBloc, PriceQuotationCancelState>(
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
          BlocListener<FetchingPriceQuotationHeaderBloc,
              FetchingPriceQuotationHeaderState>(
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
        child: Builder(
          builder: (context) {
            return ScaffoldPage.withPadding(
              header: _header(context),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _fromDatePicker(),
                      Constant.widthSpacer,
                      Constant.widthSpacer,
                      _toDatePicker(),
                    ],
                  ),
                  Constant.heightSpacer,
                  _commandBar(context.read<FetchingPriceQuotationHeaderBloc>()),
                  Constant.heightSpacer,
                  Expanded(
                    child: _tabView(
                      context.read<FetchingPriceQuotationHeaderBloc>(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TabView _tabView(FetchingPriceQuotationHeaderBloc bloc) {
    return TabView(
      tabWidthBehavior: TabWidthBehavior.sizeToContent,
      currentIndex: currentIndex,
      closeButtonVisibility: CloseButtonVisibilityMode.never,
      onChanged: (index) {
        setState(
          () {
            currentIndex = index;
            pqStatus = index;
            if (index == 0 || index == 1) {
              fromDate = null;
              toDate = null;
              docStatus = "O";
            } else if (index == 2) {
              fromDate = DateTime.now();
              toDate = DateTime.now();
              docStatus = "O";
            } else {
              fromDate = DateTime.now();
              toDate = DateTime.now();
              // if (index == 3) {
              //   docStatus = "C";
              //   pqStatus = null;
              // } else {
              docStatus = "N";
              pqStatus = null;
              // }
            }
          },
        );

        bloc.add(
          FetchAllPriceQuotationHeader(
            docStatus: docStatus,
            pqStatus: pqStatus,
            fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
            toDate: toDate == null ? "" : dateFormat.format(toDate!),
          ),
        );
      },
      tabs: [
        Tab(
          icon: const ImageIcon(
            AssetImage('assets/icons/open_document.png'),
          ),
          text: BlocBuilder<FetchingPriceQuotationHeaderBloc,
              FetchingPriceQuotationHeaderState>(
            builder: (context, state) {
              return Badge(
                badgeContent: Text(
                  state.forPriceConfirmation.toString(),
                ),
                position: BadgePosition.topStart(),
                child: Text(
                  "For Price Confirmation",
                  style: (currentIndex == 0)
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.teal.lightest)
                      : null,
                ),
              );
            },
          ),
          body: PriceQuotationHeaderTable(
            sfDataGridKey: sfDataGridKey,
            docStatus: docStatus,
            fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
            toDate: toDate == null ? "" : dateFormat.format(toDate!),
            pqStatus: pqStatus,
          ),
        ),
        Tab(
          icon: const ImageIcon(
            AssetImage('assets/icons/open_document.png'),
          ),
          text: BlocBuilder<FetchingPriceQuotationHeaderBloc,
              FetchingPriceQuotationHeaderState>(
            builder: (context, state) {
              return Badge(
                badgeContent: Text(
                  state.forCreditConfirmation.toString(),
                ),
                position: BadgePosition.topStart(),
                child: Text(
                  "For SAP SQ",
                  style: (currentIndex == 1)
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.teal.lightest)
                      : null,
                ),
              );
            },
          ),
          body: PriceQuotationHeaderTable(
            sfDataGridKey: sfDataGridKey,
            docStatus: docStatus,
            fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
            toDate: toDate == null ? "" : dateFormat.format(toDate!),
            pqStatus: pqStatus,
          ),
        ),
        Tab(
          icon: const ImageIcon(
            AssetImage('assets/icons/open_document.png'),
          ),
          text: Text(
            "With SAP SQ",
            style: (currentIndex == 2)
                ? TextStyle(
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.teal.lightest)
                : null,
          ),
          body: PriceQuotationHeaderTable(
            sfDataGridKey: sfDataGridKey,
            docStatus: docStatus,
            fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
            toDate: toDate == null ? "" : dateFormat.format(toDate!),
            pqStatus: pqStatus,
          ),
        ),
        // Tab(
        //   icon: const ImageIcon(
        //     AssetImage('assets/icons/done_document.png'),
        //   ),
        //   text: Text(
        //     "Dispatched",
        //     style: (currentIndex == 3)
        //         ? TextStyle(
        //             fontWeight: FontWeight.bold,
        //             backgroundColor: Colors.teal.lightest)
        //         : null,
        //   ),
        //   body: PriceQuotationHeaderTable(
        //     sfDataGridKey: sfDataGridKey,
        //     docStatus: "C",
        //     fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
        //     toDate: toDate == null ? "" : dateFormat.format(toDate!),
        //     pqStatus: pqStatus,
        //     branch: _selectedBranchController.text,
        //   ),
        // ),
        Tab(
          icon: const ImageIcon(
            AssetImage('assets/icons/delete_document.png'),
          ),
          text: Text(
            "Canceled",
            style: (currentIndex == 4)
                ? TextStyle(
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.teal.lightest)
                : null,
          ),
          body: PriceQuotationHeaderTable(
            sfDataGridKey: sfDataGridKey,
            docStatus: "N",
            fromDate: fromDate == null ? "" : dateFormat.format(fromDate!),
            toDate: toDate == null ? "" : dateFormat.format(toDate!),
            pqStatus: null,
          ),
        ),
      ],
    );
  }

  CommandBarCard _commandBar(FetchingPriceQuotationHeaderBloc bloc) {
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
              icon: const Icon(FluentIcons.search),
              label: const Text("Filter"),
              onPressed: () {
                bloc.add(
                  FetchAllPriceQuotationHeader(
                    docStatus: docStatus,
                    pqStatus: pqStatus,
                    fromDate:
                        fromDate == null ? "" : dateFormat.format(fromDate!),
                    toDate: toDate == null ? "" : dateFormat.format(toDate!),
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
      label: "Transaction Date",
      width: Constant.calendarWidth,
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
      label: "Transaction Date",
      width: Constant.calendarWidth,
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
      title: const Text("Price Quotations"),
    );
  }
}
