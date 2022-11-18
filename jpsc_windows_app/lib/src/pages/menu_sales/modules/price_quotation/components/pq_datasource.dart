part of 'pq_table.dart';

class DataSource extends DataGridSource {
  late BuildContext cntx;
  List<PriceQuotationModel> datas;
  final void Function() onRefresh;
  late List<PriceQuotationModel> paginatedDatas;
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
      return TableSettings.dataGrid(data);
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
                    PriceQuotationModel priceQuotation =
                        datas.firstWhere((i) => i.id == dataGridCell.value);

                    cntx.router.navigate(
                      PriceQuotationWrapper(
                        children: [
                          PriceQuotationHeaderDetailsRoute(
                            header: "Price Quotation Details",
                            priceQuotation: priceQuotation,
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
      } else if (dataGridCell.columnName == 'Action') {
        return Container(
          alignment: Alignment.center,
          child: DropDownButton(
            disabled: dataGridCell.value.docstatus == 'N',
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
                    cntx,
                    message:
                        "Are you sure you want to cancel this transaction?",
                    onPositiveClick: (dialogContext, remarks) {
                      cntx.read<PriceQuotationCancelBloc>().add(
                            PriceQuotationCancelSubmitted(
                                dataGridCell.value.id!, remarks),
                          );
                      dialogContext.router.pop();
                    },
                  );
                },
              ),
            ],
          ),
        );
      } else if (dataGridCell.columnName == 'Subtotal') {
        return Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: SelectableText(formatStringToDecimal("${dataGridCell.value}")),
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
                    : SelectableText(dataGridCell.value.toString()),
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
    "branch": {"name": "Branch", "width": double.nan},
    "customerCode": {"name": "Customer Code", "width": double.nan},
    "details": {"name": "Details", "width": double.nan},
    "subtotal": {"name": "Subtotal", "width": double.nan},
    "remarks": {"name": "Remarks", "width": double.nan},
    "contactNumber": {"name": "Contact Number", "width": double.nan},
    "address": {"name": "Address", "width": double.nan},
    "createdBy": {"name": "Created By", "width": double.nan},
    "approvedBy": {"name": "Approved By", "width": double.nan},
    "updatedBy": {"name": "Updated By", "width": double.nan},
    "canceledBy": {"name": "Canceled By", "width": double.nan},
    "canceledRemarks": {"name": "Canceled Remarks", "width": double.nan},
    "action": {"name": "Action", "width": double.nan},
  };

  static DataGridRow dataGrid(PriceQuotationModel priceQuotation) {
    return DataGridRow(
      cells: [
        DataGridCell<int>(
            columnName: columnName["id"]["name"], value: priceQuotation.id),
        DataGridCell<String>(
            columnName: columnName["reference"]["name"],
            value: priceQuotation.reference),
        DataGridCell<DateTime>(
          columnName: columnName["transDate"]["name"],
          value: priceQuotation.transdate,
        ),
        DataGridCell<String>(
          columnName: columnName["deliveryDate"]["name"],
          value: dateFormatter(
            priceQuotation.deliveryDate,
            DateFormat('MM/dd/yyyy'),
          ),
        ),
        DataGridCell<String>(
          columnName: columnName["branch"]["name"],
          value: priceQuotation.dispatchingBranch,
        ),
        DataGridCell<String>(
          columnName: columnName["customerCode"]["name"],
          value: priceQuotation.customerCode,
        ),
        DataGridCell<String>(
          columnName: columnName["details"]["name"],
          value: priceQuotation.rows.join("\n"),
        ),
        DataGridCell<double>(
          columnName: columnName["subtotal"]["name"],
          value: priceQuotation.subtotal ?? 0.00,
        ),
        DataGridCell<String>(
          columnName: columnName["remarks"]["name"],
          value: priceQuotation.remarks,
        ),
        DataGridCell<String>(
          columnName: columnName["contactNumber"]["name"],
          value: priceQuotation.contactNumber,
        ),
        DataGridCell<String>(
          columnName: columnName["address"]["name"],
          value: priceQuotation.address,
        ),
        DataGridCell<String>(
          columnName: columnName["createdBy"]["name"],
          value: priceQuotation.createdByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["approvedBy"]["name"],
          value: priceQuotation.approvedByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["updatedBy"]["name"],
          value: priceQuotation.updatedByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["canceledBy"]["name"],
          value: priceQuotation.canceledByUser?.email ?? "",
        ),
        DataGridCell<String>(
          columnName: columnName["canceledRemarks"]["name"],
          value: priceQuotation.canceledRemarks ?? "",
        ),
        DataGridCell(
          columnName: columnName["action"]["name"],
          value: priceQuotation,
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
