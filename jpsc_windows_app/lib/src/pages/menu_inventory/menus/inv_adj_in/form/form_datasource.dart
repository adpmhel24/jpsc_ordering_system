part of 'form_table.dart';

class DataSource extends DataGridSource {
  BuildContext cntx;
  List<InventoryAdjustmentInRow> itemRows;
  late List<InventoryAdjustmentInRow> paginatedData;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

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
    paginatedData =
        itemRows.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedData.asMap().entries.map((element) {
      int index = element.key + startIndex;
      InventoryAdjustmentInRow val = element.value;
      return FormTableSettings.dataGrid(cntx, index, val);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * rowsPerPage;
    endIndex = startIndex + rowsPerPage;
    if (startIndex < itemRows.length && endIndex <= itemRows.length) {
      paginatedData =
          itemRows.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < itemRows.length && endIndex > itemRows.length) {
      paginatedData = itemRows
          .getRange(startIndex, itemRows.length)
          .toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else {
      paginatedData = [];
    }

    return true;
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: Constant.minPadding),
        child: dataGridCell.value.runtimeType != DropDownButton
            ? SelectableText(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}
