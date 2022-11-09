import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart' as m;

import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';
import '../blocs/fetching_bloc/bloc.dart';

class CustomersTable extends StatefulWidget {
  const CustomersTable({
    Key? key,
    required this.sfDataGridKey,
    required this.onRefresh,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  final void Function() onRefresh;

  @override
  State<CustomersTable> createState() => _CustomersTableState();
}

class _CustomersTableState extends State<CustomersTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page
  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerFetchingBloc, CustomerFetchingState>(
      buildWhen: (prev, curr) =>
          curr.status == FetchingStatus.unauthorized ||
          curr.status == FetchingStatus.success,
      builder: (context, state) {
        if (state.status == FetchingStatus.unauthorized) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.status == FetchingStatus.success) {
          _dataSource = DataSource(
            context,
            datas: state.datas,
            startIndex: _startIndex,
            endIndex: _endIndex,
            rowsPerPage: _rowsPerPage,
            onRefresh: widget.onRefresh,
          );
          return Card(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tableBody(constraint),
                    tableFooter(state.datas.length),
                  ],
                );
              },
            ),
          );
        }
        return const SizedBox.expand();
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
              key: widget.sfDataGridKey,
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

  SizedBox tableFooter(int dataLength) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: dataLength <= 0
            ? 1
            : (dataLength / _rowsPerPage) +
                ((dataLength % _rowsPerPage) > 0 ? 1 : 0),
        direction: Axis.horizontal,
        availableRowsPerPage: [10, 20, 30, dataLength],
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
  List<CustomerModel> datas;
  late List<CustomerModel> paginatedDatas;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];
  final void Function() onRefresh;

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
    dataGridRows = paginatedDatas.map((customer) {
      return TableSettings.dataGrid(customer);
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
      if (dataGridCell.columnName == 'Card Code') {
        final int dataRowIndex = dataGridRows.indexOf(row);

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(Constant.minPadding),
          child: Row(
            children: [
              m.Material(
                child: m.InkWell(
                  onTap: () {
                    cntx.router.navigate(
                      CustomerWrapper(
                        children: [
                          CustomerFormRoute(
                            header: "Edit Customer",
                            selectedCustomer: paginatedDatas[dataRowIndex],
                            onRefresh: onRefresh,
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
              Flexible(child: SelectableText(dataGridCell.value)),
            ],
          ),
        );
      }
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType != Icon
            ? SelectableText(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}

class TableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Card Code", "width": double.nan},
    "fullName": {"name": "Card Name", "width": double.nan},
    "firstName": {"name": "First Name", "width": double.nan},
    "lastName": {"name": "Last Name", "width": double.nan},
    "location": {"name": "Location", "width": double.nan},
    "paymentTerm": {"name": "Payment term", "width": double.nan},
    "isActive": {"name": "Is Active", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(CustomerModel customer) {
    return DataGridRow(
      cells: [
        DataGridCell<String>(
          columnName: columnName["code"]["name"],
          value: customer.code,
        ),
        DataGridCell<String>(
            columnName: columnName["fullName"]["name"],
            value: customer.cardName),
        DataGridCell<String>(
          columnName: columnName["firstName"]["name"],
          value: customer.firstName,
        ),
        DataGridCell<String>(
          columnName: columnName["lastName"]["name"],
          value: customer.lastName ?? "",
        ),
        DataGridCell(
          columnName: columnName["location"]["name"],
          value: customer.location,
        ),
        DataGridCell(
          columnName: columnName["paymentTerm"]["name"],
          value: customer.paymentTerm,
        ),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: customer.isActive,
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
