part of 'form_table.dart';

class DataSource extends DataGridSource {
  BuildContext cntx;
  List<InventoryAdjustmentOutRow> itemRows;
  late List<InventoryAdjustmentOutRow> paginatedData;
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
      InventoryAdjustmentOutRow val = element.value;
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
      // if (dataGridCell.columnName == 'Action') {
      //   return DropDownButton(
      //     leading: const Icon(
      //       FluentIcons.settings,
      //       size: 15,
      //     ),
      //     items: [
      //       MenuFlyoutItem(
      //         leading: const Icon(
      //           FluentIcons.edit,
      //           size: 15,
      //         ),
      //         text: const Text('Edit Row'),
      //         onPressed: () {
      //           showDialog(
      //             context: cntx,
      //             useRootNavigator: false,
      //             builder: (_) => const ContentDialog(
      //               title: Text("TEst ONyl"),
      //             ),
      //           );
      //         },
      //       ),
      //       MenuFlyoutItem(
      //         leading: const Icon(
      //           FluentIcons.delete,
      //           size: 15,
      //         ),
      //         text: const Text('Delete Row'),
      //         onPressed: () => CustomDialogBox.warningMessage(
      //           cntx,
      //           message: "Are you sure you want to delete the row?",
      //           onPositiveClick: (_) {
      //             cntx
      //                 .read<InvAdjustmentInFormBloc>()
      //                 .add(DeleteRowItem(dataGridCell.value));
      //             cntx.router.pop();
      //           },
      //         ),
      //       ),
      //     ],
      //   );
      // }
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
