// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../utils/currency_formater.dart';
import '../../products/blocs/fetching_bloc/bloc.dart';
import 'pricelist_r_logs.dart';

class PricelistRowTable extends StatefulWidget {
  const PricelistRowTable({
    Key? key,
    required this.datas,
  }) : super(key: key);

  final List<PricelistRowModel> datas;

  @override
  State<PricelistRowTable> createState() => _PricelistTableState();
}

class _PricelistTableState extends State<PricelistRowTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 20;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    _dataSource = DataSource(
      context,
      datas: widget.datas,
      startIndex: _startIndex,
      endIndex: _endIndex,
      rowsPerPage: _rowsPerPage,
    );
    return Card(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              tableBody(constraint),
              tableFooter(widget.datas.length),
            ],
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
              allowEditing: true,
              editingGestureType: EditingGestureType.doubleTap,
              allowSorting: true,
              allowFiltering: true,
              allowMultiColumnSorting: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: PricelistTableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = PricelistTableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(() {
                  column["width"] = details.width;
                });

                return true;
              },
              onCellDoubleTap: (
                details,
              ) async {},
            ),
          );
  }

  SizedBox tableFooter(int pricelistLength) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: pricelistLength == 0
            ? 1
            : (pricelistLength / _rowsPerPage) +
                ((pricelistLength % _rowsPerPage) > 0 ? 1 : 0),
        direction: Axis.horizontal,
        availableRowsPerPage: [10, 20, 30, 100, pricelistLength],
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
  List<PricelistRowModel> datas;
  late List<PricelistRowModel> paginatedDatas;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

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
      return PricelistTableSettings.dataGrid(data);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<FetchingProductsBloc>().add(LoadProducts());
    buildPaginatedDataGridRows();
    notifyListeners();
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
  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final columnsToEdit = [
      "Suggested Price",
      "Logistics Cost",
    ];
    if (columnsToEdit.contains(column.columnName)) {
      return true;
    } else if (column.columnName == "Profit" &&
        cntx.read<CurrentUserRepo>().currentUser.isSuperAdmin) {
      return true;
    }
    return false;
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    PricelistRowModel dataRow = paginatedDatas[dataRowIndex];

    if (column.columnName == 'Suggested Price') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
        columnName: 'Suggested Price',
        value: newCellValue,
      );
      dataRow.price = newCellValue;

      final double computedProfit =
          newCellValue - dataRow.lastPurchasedPrice - dataRow.logisticsCost;
      // Assign the computed profit
      dataRow.profit = double.parse(computedProfit.toStringAsFixed(2));
    } else if (column.columnName == 'Logistics Cost') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
        columnName: 'Logistics Cost',
        value: newCellValue,
      );
      dataRow.logisticsCost = newCellValue;

      final computedProfit =
          dataRow.price - dataRow.lastPurchasedPrice - newCellValue;

      dataRow.profit = double.parse(computedProfit.toStringAsFixed(2));
    } else if (column.columnName == 'Profit') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
        columnName: 'Profit',
        value: newCellValue,
      );
      dataRow.profit = newCellValue;

      var computedSP =
          dataRow.lastPurchasedPrice + dataRow.logisticsCost + newCellValue;
      // Computed Suggested Selling Price
      dataRow.price = double.parse(computedSP.toStringAsFixed(2));
    }
    notifyListeners();
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;
    final columnsToEdit = [
      "Suggested Price",
      "Logistics Cost",
      "Profit",
    ];

    final bool isNumericType = columnsToEdit.contains(column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextFormBox(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = double.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        onFieldSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final currUserRepo = cntx.read<CurrentUserRepo>();

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final int dataRowIndex = dataGridRows.indexOf(row);

      if (dataGridCell.columnName == "Logs") {
        return Container(
          alignment: Alignment.center,
          child: CustomButton(
            child: const Text("Logs"),
            onPressed: () {
              showDialog(
                context: cntx,
                builder: (context) => PricelistRowLogDialogContent(
                  pricelistRowId: dataGridCell.value,
                ),
              );
            },
          ),
        );
      }
      if (dataGridCell.columnName == "Last Purchased Price" &&
          !currUserRepo.checkIfGrantToViewLastPurch(
              paginatedDatas[dataRowIndex].item?.itemGroupCode ?? "") &&
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
          alignment: Alignment.centerRight,
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
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType == String
            ? SelectableText(dataGridCell.value.toString())
            : dataGridCell.value.runtimeType == double
                ? Text(formatStringToDecimal('${dataGridCell.value}'))
                : dataGridCell.value,
      );
    }).toList());
  }
}

class PricelistTableSettings {
  static Map<String, dynamic> columnName = {
    "pricelistCode": {"name": "Pricelist Code", "width": double.nan},
    "itemCode": {"name": "Item Code", "width": double.nan},
    "itemGroup": {"name": "Item Group", "width": double.nan},
    "lastPurchasedPrice": {"name": "Last Purchased Price", "width": double.nan},
    "avgSapValue": {"name": "Avg SAP Value", "width": double.nan},
    "price": {"name": "Suggested Price", "width": double.nan},
    "logisticsCost": {"name": "Logistics Cost", "width": double.nan},
    "profit": {"name": "Profit", "width": double.nan},
    "uom": {"name": "UoM", "width": double.nan},
    "logs": {"name": "Logs", "width": double.nan},
  };

  static DataGridRow dataGrid(PricelistRowModel data) {
    return DataGridRow(
      cells: [
        DataGridCell(
            columnName: columnName["pricelistCode"]["name"],
            value: data.pricelistCode),
        DataGridCell(
            columnName: columnName["itemCode"]["name"], value: data.itemCode),
        DataGridCell(
            columnName: columnName["itemGroup"]["name"],
            value: data.item?.itemGroupCode),
        DataGridCell<double>(
          columnName: columnName["lastPurchasedPrice"]["name"],
          value: data.lastPurchasedPrice,
        ),
        DataGridCell<double>(
          columnName: columnName["avgSapValue"]["name"],
          value: data.avgSapValue,
        ),
        DataGridCell<double>(
          columnName: columnName["price"]["name"],
          value: data.price,
        ),
        DataGridCell<double>(
          columnName: columnName["logisticsCost"]["name"],
          value: data.logisticsCost,
        ),
        DataGridCell<double>(
          columnName: columnName["profit"]["name"],
          value: data.profit,
        ),
        DataGridCell<String>(
          columnName: columnName["uom"]["name"],
          value: data.uomCode,
        ),
        DataGridCell(
          columnName: columnName["logs"]["name"],
          value: data.id,
        ),
      ],
    );
  }

  static List<GridColumn> get columns {
    return columnName.entries.map(
      (e) {
        return GridColumn(
          width: e.value["width"],
          columnName: e.value["name"],
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              e.value["name"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    ).toList();
  }
}
