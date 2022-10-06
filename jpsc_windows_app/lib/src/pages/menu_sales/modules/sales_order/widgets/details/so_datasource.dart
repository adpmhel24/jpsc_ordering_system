part of 'so_details_table.dart';

class DataSource extends DataGridSource {
  BuildContext cntx;
  List<SalesOrderRowModel> itemRows;
  late List<SalesOrderRowModel> paginatedDatas;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  DataSource(
    this.cntx, {
    required this.itemRows,
    required this.startIndex,
    required this.endIndex,
    required this.rowsPerPage,
  }) {
    if (itemRows.length < endIndex) {
      endIndex = itemRows.length;
    }
    paginatedDatas =
        itemRows.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedDatas.asMap().entries.map((element) {
      int index = element.key + startIndex;
      SalesOrderRowModel val = element.value;
      return TableSettings.dataGrid(cntx, index, val);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * rowsPerPage;
    endIndex = startIndex + rowsPerPage;
    if (startIndex < itemRows.length && endIndex <= itemRows.length) {
      paginatedDatas =
          itemRows.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < itemRows.length && endIndex > itemRows.length) {
      paginatedDatas = itemRows
          .getRange(startIndex, itemRows.length)
          .toList(growable: false);
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
    SalesOrderModel selectedSalesOrder =
        cntx.read<SalesOrderUpdateBloc>().selectedSalesOrder;
    if (column.columnName == 'Actual Price' &&
        selectedSalesOrder.orderStatus == 0 &&
        selectedSalesOrder.docstatus == "O") {
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

    if (column.columnName == 'Actual Price') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Actual Price', value: newCellValue);

      paginatedDatas[dataRowIndex].unitPrice = newCellValue;
      // Change the data of total

      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 2] =
          DataGridCell<double>(
              columnName: 'Total',
              value: newCellValue * paginatedDatas[dataRowIndex].quantity);
      paginatedDatas[dataRowIndex].linetotal =
          newCellValue * paginatedDatas[dataRowIndex].quantity;
      notifyListeners();
      // Update the SalesOrderRows
      cntx.read<SalesOrderUpdateBloc>().add(SalesOrderRowsChanged(itemRows));
    }
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

    final bool isNumericType = column.columnName == 'Actual Price';

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
    double srpPrice = row.getCells()[3].value;
    double actualPrice = row.getCells()[4].value;
    return DataGridRowAdapter(
        color: (srpPrice > actualPrice)
            ? Colors.red.light
            : (srpPrice < actualPrice)
                ? Colors.green.light
                : null,
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: dataGridCell.value.runtimeType == double
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding:
                const EdgeInsets.symmetric(horizontal: Constant.minPadding),
            child: dataGridCell.value.runtimeType == String
                ? Text(dataGridCell.value)
                : dataGridCell.value.runtimeType == double
                    ? Text(formatStringToDecimal("${dataGridCell.value}"))
                    : dataGridCell.value,
          );
        }).toList());
  }
}

class TableSettings {
  static Map<String, dynamic> columnName = {
    "item_code": {"name": "Item Code", "width": double.nan},
    "item_description": {"name": "Item Description", "width": double.nan},
    "quantity": {"name": "Quantity", "width": double.nan},
    "srpPrice": {"name": "Srp Price", "width": double.nan},
    "unitPrice": {"name": "Actual Price", "width": double.nan},
    "uom": {"name": "UoM", "width": double.nan},
    "total": {"name": "Total", "width": double.nan},
  };

  static DataGridRow dataGrid(
      BuildContext context, int index, SalesOrderRowModel data) {
    return DataGridRow(
      cells: [
        DataGridCell<String>(
            columnName: columnName["item_code"]["name"], value: data.itemCode),
        DataGridCell<String>(
            columnName: columnName["item_description"]["name"],
            value: data.itemDescription),
        DataGridCell<double>(
          columnName: columnName["quantity"]["name"],
          value: data.quantity,
        ),
        DataGridCell<double>(
          columnName: columnName["srpPrice"]["name"],
          value: data.srpPrice,
        ),
        DataGridCell<double>(
            columnName: columnName["unitPrice"]["name"], value: data.unitPrice),
        DataGridCell<String>(
            columnName: columnName["uom"]["name"], value: data.uom),
        DataGridCell<double>(
            columnName: columnName["total"]["name"], value: data.linetotal),
      ],
    );
  }

  static List<GridColumn> get columns {
    return columnName.entries.map(
      (e) {
        return GridColumn(
          allowEditing: true,
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
