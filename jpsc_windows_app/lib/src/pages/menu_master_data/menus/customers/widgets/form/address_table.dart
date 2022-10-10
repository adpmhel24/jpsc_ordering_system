import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../global_blocs/bloc_customer/creating_update_bloc/bloc.dart';
import '../../../../../widgets/custom_dialog.dart';
import 'address_form_modal.dart';

class CustomerFormAddressTable extends StatefulWidget {
  const CustomerFormAddressTable({Key? key, required this.addresses})
      : super(key: key);
  final List<CustomerAddressModel> addresses;

  @override
  State<CustomerFormAddressTable> createState() =>
      _CustomeFormrAddressTableState();
}

class _CustomeFormrAddressTableState extends State<CustomerFormAddressTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page
  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    _dataSource = DataSource(
      context,
      datas: widget.addresses,
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
              tableFooter(widget.addresses.length),
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
              allowSorting: true,
              allowMultiColumnSorting: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: TableSettings.columns,
              columnWidthMode: ColumnWidthMode.fill,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(() {
                  column["width"] = details.width;
                });

                return true;
              },
            ),
          );
  }

  SizedBox tableFooter(int dataCount) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: dataCount == 0
            ? 1
            : (dataCount / _rowsPerPage) +
                ((dataCount % _rowsPerPage) > 0 ? 1 : 0),
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
  List<CustomerAddressModel> datas;
  late List<CustomerAddressModel> paginatedDatas;
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
    dataGridRows = paginatedDatas.map((customerAddress) {
      return TableSettings.dataGrid(customerAddress);
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
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Action') {
        final int dataRowIndex = dataGridRows.indexOf(row);

        return DropDownButton(
          leading: const Icon(
            FluentIcons.settings,
            size: 15,
          ),
          items: [
            MenuFlyoutItem(
              leading: const Icon(
                FluentIcons.edit,
                size: 15,
              ),
              text: const Text('Edit Row'),
              onPressed: () {
                showDialog(
                  context: cntx,
                  builder: (_) => CustomerAddressFormModal(
                    bloc: cntx.read<CreateUpdateCustomerBloc>(),
                    currentIndex: dataRowIndex,
                    selectedAddressObj: paginatedDatas[dataRowIndex],
                  ),
                );
              },
            ),
            MenuFlyoutItem(
              leading: const Icon(
                FluentIcons.delete,
                size: 15,
              ),
              text: const Text('Delete Row'),
              onPressed: () => CustomDialogBox.warningMessage(
                cntx,
                message: "Are you sure you want to delete the row?",
                onPositiveClick: (dialogBoxContext) {
                  cntx
                      .read<CreateUpdateCustomerBloc>()
                      .add(CustAddressRemoved(dataRowIndex));
                  dialogBoxContext.router.pop();
                },
              ),
            ),
          ],
        );
      }
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType == String
            ? SelectableText(dataGridCell.value)
            : dataGridCell.value,
      );
    }).toList());
  }
}

class TableSettings {
  static Map<String, dynamic> columnName = {
    "action": {"name": "Action", "width": 100.0},
    "street": {"name": "Street Address", "width": double.nan},
    "brgy": {"name": "Brgy", "width": double.nan},
    "cityMunicipality": {"name": "City / Municipality", "width": double.nan},
    "province": {"name": "Province", "width": double.nan},
    "otherDetails": {"name": "Other Details", "width": double.nan},
    "isDefault": {"name": "Default", "width": double.nan},
  };

  static DataGridRow dataGrid(CustomerAddressModel data) {
    return DataGridRow(
      cells: [
        DataGridCell(
          columnName: columnName["action"]["name"],
          value: data,
        ),
        DataGridCell<String>(
            columnName: columnName["street"]["name"],
            value: data.streetAddress),
        DataGridCell<String>(
            columnName: columnName["brgy"]["name"], value: data.brgy),
        DataGridCell<String>(
            columnName: columnName["cityMunicipality"]["name"],
            value: data.cityMunicipality),
        DataGridCell<String>(
          columnName: columnName["province"]["name"],
          value: data.province,
        ),
        DataGridCell<String>(
          columnName: columnName["otherDetails"]["name"],
          value: data.otherDetails,
        ),
        DataGridCell<Icon>(
          columnName: columnName["isDefault"]["name"],
          value: data.isDefault!
              ? const Icon(FluentIcons.check_mark)
              : const Icon(FluentIcons.status_circle_error_x),
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
