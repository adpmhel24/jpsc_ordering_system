part of 'sales_order_table.dart';

class DataSource extends DataGridSource {
  late BuildContext cntx;
  List<SalesOrderModel> datas;
  final void Function() onRefresh;
  late List<SalesOrderModel> paginatedDatas;
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
    required this.onRefresh,
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
      return TableSettings.dataGrid(cntx, data);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    onRefresh();
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
                    SalesOrderModel salesOrder =
                        datas.firstWhere((i) => i.id == dataGridCell.value);

                    cntx.router.navigate(
                      SalesOrderWrapper(
                        children: [
                          SalesOrderHeaderDetailsRoute(
                            header: "Sales Order Details",
                            salesOrder: salesOrder,
                            onRefresh: handleRefresh,
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
      } else if (dataGridCell.columnName == 'Cancel') {
        return dataGridCell.value;
      }
      return Container(
        alignment: dataGridCell.value.runtimeType == double
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
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
    "id": {"name": "Id", "width": double.nan},
    "reference": {"name": "Reference", "width": double.nan},
    "transDate": {"name": "Posting Date", "width": double.nan},
    "deliveryDate": {"name": "Delivery Date", "width": double.nan},
    "customerCode": {"name": "Customer Code", "width": double.nan},
    "paymentTerm": {"name": "Payment Term", "width": double.nan},
    "details": {"name": "Details", "width": double.nan},
    "subtotal": {"name": "Subtotal", "width": double.nan},
    "remarks": {"name": "Remarks", "width": double.nan},
    "contactNumber": {"name": "Contact Number", "width": double.nan},
    "address": {"name": "Address", "width": double.nan},
    "createdBy": {"name": "Created By", "width": double.nan},
    "updatedBy": {"name": "Updated By", "width": double.nan},
    "canceledBy": {"name": "Canceled By", "width": double.nan},
    "canceledRemarks": {"name": "Canceled Remarks", "width": double.nan},
    "action": {
      "name": "Action",
      "width": 80.0,
    },
  };

  static DataGridRow dataGrid(
      BuildContext context, SalesOrderModel salesOrder) {
    return DataGridRow(
      cells: [
        DataGridCell<int>(
            columnName: columnName["id"]["name"], value: salesOrder.id),
        DataGridCell<String>(
            columnName: columnName["reference"]["name"],
            value: salesOrder.reference),
        DataGridCell<String>(
          columnName: columnName["transDate"]["name"],
          value: dateFormatter(salesOrder.transdate),
        ),
        DataGridCell<String>(
          columnName: columnName["deliveryDate"]["name"],
          value: dateFormatter(
            salesOrder.deliveryDate,
            DateFormat('MM/dd/yyyy'),
          ),
        ),
        DataGridCell<String>(
          columnName: columnName["customerCode"]["name"],
          value: salesOrder.customerCode,
        ),
        DataGridCell<String>(
          columnName: columnName["paymentTerm"]["name"],
          value: salesOrder.paymentTerm,
        ),
        DataGridCell<String>(
          columnName: columnName["details"]["name"],
          value: salesOrder.rows.join("\n"),
        ),
        DataGridCell<double>(
          columnName: columnName["subtotal"]["name"],
          value: salesOrder.subtotal,
        ),
        DataGridCell<String>(
          columnName: columnName["remarks"]["name"],
          value: salesOrder.remarks,
        ),
        DataGridCell<String>(
          columnName: columnName["contactNumber"]["name"],
          value: salesOrder.contactNumber,
        ),
        DataGridCell<String>(
          columnName: columnName["address"]["name"],
          value: salesOrder.address,
        ),
        DataGridCell<String>(
          columnName: columnName["createdBy"]["name"],
          value: salesOrder.createdByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["updatedBy"]["name"],
          value: salesOrder.updatedByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["canceledBy"]["name"],
          value: salesOrder.canceledByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["canceledRemarks"]["name"],
          value: salesOrder.canceledRemarks ?? "",
        ),
        DataGridCell<SizedBox>(
          columnName: columnName["action"]["name"],
          value: SizedBox(
            child: DropDownButton(
              disabled: salesOrder.docstatus == 'N',
              leading: const Icon(
                FluentIcons.settings,
                size: 15,
              ),
              items: [
                MenuFlyoutItem(
                  leading: const Icon(
                    FluentIcons.cancel,
                    size: 15,
                  ),
                  text: const Text('Cancel'),
                  onPressed: () {
                    CustomDialogBox.warningWithRemarks(
                      context,
                      message:
                          "Are you sure you want to cancel this transaction?",
                      onPositiveClick: (cntx, remarks) {
                        context.read<SalesOrderCancelBloc>().add(
                              SalesOrderCancelSubmitted(
                                  salesOrder.id!, remarks),
                            );
                        cntx.router.pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
