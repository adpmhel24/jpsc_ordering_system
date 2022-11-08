import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:jpsc_windows_app/src/data/models/table_col_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/currency_formater.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../../utils/fetching_status.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/fetching_pricelistRowLogs_bloc/bloc.dart';

class PricelistRowLogDialogContent extends StatelessWidget {
  const PricelistRowLogDialogContent({
    super.key,
    required this.pricelistRowId,
  });
  final int pricelistRowId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FetchingPricelistRowLogsBloc(
        context.read<PricelistRepo>(),
      )..add(LoadPricelistRowLogs(pricelistRowId)),
      child: BlocListener<FetchingPricelistRowLogsBloc,
          FetchingPricelistRowLogsState>(
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
        child: ContentDialog(
          title: const Text("Pricelist Row Logs"),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .9,
              maxWidth: Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width * .8
                  : MediaQuery.of(context).size.width),
          actions: [
            Button(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          content: const LogsTable(),
        ),
      ),
    );
  }
}

class LogsTable extends StatefulWidget {
  const LogsTable({super.key});

  @override
  State<LogsTable> createState() => _LogsTableState();
}

class _LogsTableState extends State<LogsTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10;
  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<FetchingPricelistRowLogsBloc,
          FetchingPricelistRowLogsState>(
        buildWhen: (prev, curr) => curr.status == FetchingStatus.success,
        builder: (context, state) {
          _dataSource = DataSource(
            context,
            datas: state.datas,
            startIndex: _startIndex,
            endIndex: _endIndex,
            rowsPerPage: _rowsPerPage,
          );

          return LayoutBuilder(
            builder: (context, constraint) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  tableBody(constraint),
                  tableFooter(state.datas.length),
                ],
              );
            },
          );
        },
      ),
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
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.columNames()
                    .firstWhere((e) => e.name == details.column.columnName);
                setState(() {
                  column.width = details.width;
                });

                return true;
              },
            ),
          );
  }

  SizedBox tableFooter(int datasLength) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: datasLength <= 0
            ? 1
            : (datasLength / _rowsPerPage) +
                ((datasLength % _rowsPerPage) > 0 ? 1 : 0),
        direction: Axis.horizontal,
        availableRowsPerPage: const [10, 20, 30],
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
            _dataSource.updateDataGriDataSource();
          });
        },
      ),
    );
  }
}

class DataSource extends DataGridSource {
  late BuildContext cntx;
  List<PricelistRowLogModel> datas;
  late List<PricelistRowLogModel> paginatedDatas;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

  DataSource(
    this.cntx, {
    required this.datas,
    required this.startIndex,
    required this.endIndex,
    required this.rowsPerPage,
  }) {
    if (datas.length < endIndex) {
      endIndex = datas.length;
    }
    paginatedDatas =
        datas.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedDatas.map((data) {
      return TableSettings.dataGrid(data);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * rowsPerPage;
    endIndex = startIndex + rowsPerPage;
    if (startIndex < datas.length && endIndex <= datas.length) {
      paginatedDatas =
          datas.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < datas.length && endIndex > datas.length) {
      paginatedDatas =
          datas.getRange(startIndex, datas.length).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else {
      paginatedDatas = [];
    }

    return true;
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final currUserRepo = cntx.read<CurrentUserRepo>();

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final int dataRowIndex = dataGridRows.indexOf(row);

      if (dataGridCell.columnName == "Last Purchased Price" &&
          !currUserRepo.checkIfGrantToViewLastPurch(
              paginatedDatas[dataRowIndex].item?.itemGroupCode ?? "wew") &&
          !currUserRepo.currentUser.isSuperAdmin) {
        return Container(
          alignment: Alignment.centerRight,
          child: const Icon(FluentIcons.hide),
        );
      }
      if (dataGridCell.columnName == "Avg SAP Value" &&
          !currUserRepo.checkIfGrantToViewAvgSAP(
              paginatedDatas[dataRowIndex].item?.itemGroupCode ?? "") &&
          !currUserRepo.currentUser.isSuperAdmin) {
        return Container(
          alignment: Alignment.centerRight,
          child: const Icon(FluentIcons.hide),
        );
      }
      if (dataGridCell.columnName == "Profit" &&
          !currUserRepo.checkIfGrantToViewLastPurch(
              paginatedDatas[dataRowIndex].item?.itemGroupCode ?? "") &&
          !currUserRepo.currentUser.isSuperAdmin) {
        return Container(
          alignment: Alignment.center,
          child: Icon(
            dataGridCell.value > 0
                ? FluentIcons.like
                : dataGridCell.value < 0
                    ? FluentIcons.dislike
                    : FluentIcons.remove,
            color: dataGridCell.value > 0
                ? Colors.green.light
                : dataGridCell.value < 0
                    ? Colors.red.light
                    : null,
          ),
        );
      }

      return Container(
        alignment: dataGridCell.value.runtimeType == double
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: dataGridCell.value.runtimeType == String
            ? SelectableText(dataGridCell.value)
            : dataGridCell.value.runtimeType == double
                ? SelectableText(formatStringToDecimal("${dataGridCell.value}"))
                : dataGridCell.value.runtimeType == DateTime
                    ? SelectableText(dateFormatter(dataGridCell.value))
                    : dataGridCell.value,
      );
    }).toList());
  }
}

class TableSettings {
  static List<ColumnName> columNames([PricelistRowLogModel? logObj]) {
    return [
      ColumnName<String?>(
        name: "Item Code",
        width: double.nan,
        value: logObj?.itemCode,
      ),
      ColumnName<double?>(
        name: "Last Purchased Price",
        width: double.nan,
        value: logObj?.lastPurchasedPrice,
      ),
      ColumnName<double?>(
        name: "Avg SAP Value",
        width: double.nan,
        value: logObj?.avgSapValue,
      ),
      ColumnName<double?>(
        name: "Selling Price",
        width: double.nan,
        value: logObj?.price,
      ),
      ColumnName<double?>(
        name: "Logistics Cost",
        width: double.nan,
        value: logObj?.logisticsCost,
      ),
      ColumnName<double?>(
        name: "Profit",
        width: double.nan,
        value: logObj?.profit,
      ),
      ColumnName<DateTime?>(
        name: "Date Updated",
        width: double.nan,
        value: logObj?.dateUpdated,
      ),
      ColumnName<String?>(
        name: "Updated By",
        width: double.nan,
        value: logObj?.updatedByUser?.email ?? "",
      ),
    ];
  }

  static DataGridRow dataGrid(PricelistRowLogModel data) {
    return DataGridRow(
      cells: columNames(data)
          .map(
            (e) => DataGridCell(
              columnName: e.name,
              value: e.value,
            ),
          )
          .toList(),
    );
  }

  static List<GridColumn> get columns {
    return columNames()
        .map((e) => GridColumn(
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
            ))
        .toList();
  }
}
