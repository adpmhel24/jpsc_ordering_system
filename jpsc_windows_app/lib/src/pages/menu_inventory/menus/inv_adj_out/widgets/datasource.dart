part of 'table.dart';

class DataSource extends DataGridSource {
  late BuildContext cntx;
  List<InventoryAdjustmentOutModel> datas;
  late List<InventoryAdjustmentOutModel> paginatedDatas;
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
      return InvAdjustmentTableSettings.dataGrid(cntx, data);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<InvAdjustmentOutBloc>().add(RefreshInvAdjOut());
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
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Id') {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(Constant.minPadding),
          child: Row(
            children: [
              m.Material(
                child: m.InkWell(
                  onTap: () {
                    InventoryAdjustmentOutModel invAdjustmentOut =
                        datas.firstWhere((i) => i.id == dataGridCell.value);

                    cntx.router.navigate(
                      InvAdjOutWrapper(
                        children: [
                          InvAdjustmentOutDetailsRoute(
                            id: invAdjustmentOut.id,
                            header: "Inv Adjustment Out Details",
                          ),
                        ],
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/sm_right_arrow.svg",
                    color: Colors.green,
                  ),
                ),
              ),
              Flexible(child: Text("${dataGridCell.value}")),
            ],
          ),
        );
      } else if (dataGridCell.columnName == 'Action') {
        return dataGridCell.value;
      }
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType != Icon
            ? Text(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}
