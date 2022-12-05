import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:jpsc_windows_app/src/shared/widgets/custom_dialog.dart';
import 'package:jpsc_windows_app/src/utils/currency_formater.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';
import 'package:jpsc_windows_app/src/utils/responsive.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/table_col_model.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/custom_date_picker.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/date_formatter.dart';
import '../blocs/fetching_cust_trans_bloc/bloc.dart';

class CustomerTransactionsPage extends StatefulWidget {
  const CustomerTransactionsPage({
    super.key,
    @pathParam required this.customerCode,
  });

  final String customerCode;

  @override
  State<CustomerTransactionsPage> createState() =>
      _CustomerTransactionsPageState();
}

class _CustomerTransactionsPageState extends State<CustomerTransactionsPage> {
  DateTime? fromDate;
  DateTime? toDate;
  DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  CustomDatePicker _fromDatePicker() {
    return CustomDatePicker(
      label: "Transaction Date (From)",
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

  CustomDatePicker _toDatePicker() {
    return CustomDatePicker(
      label: "Transaction Date (To)",
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
      title: const Text("Transactions"),
      commandBar: Flex(
        direction:
            Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _fromDatePicker(),
          Responsive.isDesktop(context)
              ? Constant.widthSpacer
              : Constant.heightSpacer,
          _toDatePicker(),
          Responsive.isDesktop(context)
              ? Constant.widthSpacer
              : Constant.heightSpacer,
          CustomFilledButton(
            child: const Text("Filter"),
            onPressed: () {
              context.read<FetchingCustTransactionsBloc>().add(
                    LoadCustomerTransactions(
                      customerCode: widget.customerCode,
                      fromDate: dateFormat.format(fromDate!),
                      toDate: dateFormat.format(toDate!),
                      size: context
                          .read<FetchingCustTransactionsBloc>()
                          .state
                          .rowsPerPage,
                    ),
                  );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingCustTransactionsBloc(
        context.read<PriceQuotationRepo>(),
      )..add(LoadCustomerTransactions(
          customerCode: widget.customerCode,
        )),
      child: Builder(builder: (context) {
        return ScaffoldPage.withPadding(
          header: _header(context),
          content: TransactionContent(
            customerCode: widget.customerCode,
          ),
        );
      }),
    );
  }
}

class TransactionContent extends StatefulWidget {
  const TransactionContent({
    super.key,
    required this.customerCode,
  });

  final String customerCode;

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  late int rowsPerPage = 10;
  late DataSource _dataSource;
  final double _dataPagerHeight = 60.0;
  final List<int> availableRowsPerPage = [10, 20, 50, 100];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchingCustTransactionsBloc,
        FetchingCustTransactionsState>(
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
      builder: (context, state) {
        _dataSource = DataSource(
          context,
          datas: state.datas,
          startIndex: state.startIndex,
          endIndex: state.endIndex,
          rowsPerPage: state.rowsPerPage,
          onPageChanged: (page) {
            context.read<FetchingCustTransactionsBloc>().add(
                  LoadCustomerTransactions(
                    customerCode: widget.customerCode,
                    size: state.rowsPerPage,
                    page: page,
                  ),
                );
          },
          onRefresh: () {},
        );
        return Card(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  tableBody(constraint),
                  tableFooter(context.read<FetchingCustTransactionsBloc>()),
                ],
              );
            },
          ),
        );
      },
    );
  }

  SizedBox tableBody(BoxConstraints constraint) {
    double height = (constraint.maxHeight - _dataPagerHeight);
    return height < 0
        ? const SizedBox.expand()
        : SizedBox(
            height: height,
            width: constraint.maxWidth,
            child: SfDataGrid(
              source: _dataSource,
              allowSorting: true,
              allowFiltering: true,
              allowMultiColumnSorting: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: TableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onQueryRowHeight: (details) {
                return details.getIntrinsicRowHeight(details.rowIndex);
              },
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.tableColumns
                    .firstWhere((e) => e.name == details.column.columnName);
                setState(() {
                  column.width = details.width;
                });

                return true;
              },
            ),
          );
  }

  SizedBox tableFooter(FetchingCustTransactionsBloc bloc) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: bloc.state.total <= 0
            ? 1
            : (bloc.state.total / bloc.state.rowsPerPage) +
                ((bloc.state.total % bloc.state.rowsPerPage) > 0 ? 1 : 0),
        direction: Axis.horizontal,
        availableRowsPerPage: availableRowsPerPage,
        onRowsPerPageChanged: (int? rowsPerPage) {
          bloc.add(
            LoadCustomerTransactions(
              customerCode: widget.customerCode,
              size: rowsPerPage!,
            ),
          );
          setState(() {
            _dataSource.updateDataGriDataSource();
          });
        },
      ),
    );
  }
}

class DataSource extends DataGridSource {
  late BuildContext cntx;
  List<PriceQuotationModel> datas;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];
  final void Function() onRefresh;
  final void Function(int) onPageChanged;

  DataSource(
    this.cntx, {
    required this.datas,
    required this.startIndex,
    required this.endIndex,
    required this.rowsPerPage,
    required this.onRefresh,
    required this.onPageChanged,
  }) {
    if (datas.length < endIndex) {
      endIndex = datas.length;
    }
    dataGridRows = datas.map((customer) {
      return TableSettings.dataGrid(customer);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    onRefresh();
    // buildPaginatedDataGridRows();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    if (newPageIndex != oldPageIndex) {
      onPageChanged(newPageIndex + 1);
    }
    notifyListeners();
    return true;
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == 'Id') {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(Constant.minPadding),
            child: Row(
              children: [
                IconButton(
                  iconButtonMode: IconButtonMode.small,
                  onPressed: () {
                    cntx.router.navigate(
                      SalesMainWrapperPage(
                        children: [
                          PriceQuotationWrapper(
                            children: [
                              PriceQuotationHeaderDetailsRoute(
                                header: "Price Quotation Details",
                                id: dataGridCell.value,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/sm_right_arrow.svg",
                    color: Colors.green,
                  ),
                ),
                Flexible(
                    child: CopyButton(value: dataGridCell.value.toString())),
              ],
            ),
          );
        }
        return Container(
          alignment: dataGridCell.value.runtimeType == double ||
                  dataGridCell.value.runtimeType == int
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.all(5.0),
          child: dataGridCell.value.runtimeType == String
              ? CopyButton(value: dataGridCell.value.toString())
              : dataGridCell.value.runtimeType == double ||
                      dataGridCell.value.runtimeType == int
                  ? CopyButton(
                      value: formatStringToDecimal("${dataGridCell.value}"))
                  : dataGridCell.value.runtimeType == DateTime
                      ? CopyButton(value: dateFormatter(dataGridCell.value))
                      : dataGridCell.value,
        );
      },
    ).toList());
  }
}

class TableSettings {
  static final tableColumns = [
    ColumnModel(name: "Id", width: double.nan),
    ColumnModel(name: "Reference", width: double.nan),
    ColumnModel(name: "Transaction Date", width: double.nan),
    ColumnModel(name: "Details", width: double.nan),
    ColumnModel(name: "Total", width: double.nan),
    ColumnModel(name: "Created By", width: double.nan),
    ColumnModel(name: "Approved By", width: double.nan),
  ];

  static DataGridRow dataGrid(PriceQuotationModel data) {
    return DataGridRow(
      cells: [
        DataGridCell<int>(
          columnName: tableColumns[0].name,
          value: data.id,
        ),
        DataGridCell<String>(
          columnName: tableColumns[1].name,
          value: data.reference,
        ),
        DataGridCell<DateTime>(
          columnName: tableColumns[2].name,
          value: data.transdate,
        ),
        DataGridCell<String>(
          columnName: tableColumns[3].name,
          value: data.rows.join("\n"),
        ),
        DataGridCell<double>(
          columnName: tableColumns[4].name,
          value: data.subtotal ?? 0.00,
        ),
        DataGridCell<String>(
          columnName: tableColumns[5].name,
          value: data.createdByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: tableColumns[6].name,
          value: data.approvedByUser?.email ?? "",
        ),
      ],
    );
  }

  static List<GridColumn> get columns {
    return tableColumns.map(
      (e) {
        return GridColumn(
          width: e.width,
          columnName: e.name,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              e.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    ).toList();
  }
}
