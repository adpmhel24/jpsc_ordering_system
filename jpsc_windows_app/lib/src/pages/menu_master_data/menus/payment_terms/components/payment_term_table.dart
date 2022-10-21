import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';
import '../bloc/fetching_bloc/bloc.dart';

class PaymentTermTable extends StatefulWidget {
  const PaymentTermTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;

  @override
  State<PaymentTermTable> createState() => _PaymentTermTableState();
}

class _PaymentTermTableState extends State<PaymentTermTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<FetchingPaymentTermsBloc, FetchingPaymentTermsState>(
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
          }
          return const SizedBox.expand();
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
  List<PaymentTermModel> datas;
  late List<PaymentTermModel> paginatedDatas;
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
  Future<void> handleRefresh() async {
    cntx.read<FetchingPaymentTermsBloc>().add(LoadPaymentTerms());
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
      final int dataRowIndex = dataGridRows.indexOf(row);
      if (dataGridCell.columnName == 'Code') {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(Constant.minPadding),
          child: Row(
            children: [
              m.Material(
                child: m.InkWell(
                  onTap: () {
                    cntx.router.navigate(
                      PaymentTermWrapper(
                        children: [
                          PaymentTermFormRoute(
                              header: "Payment Terms Edit Form",
                              onRefresh: handleRefresh,
                              selectedPayTermObj: paginatedDatas[dataRowIndex]),
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
      } else if (dataGridCell.columnName == 'Action') {
        return DropDownButton(
          disabled: dataGridCell.value == null,
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
              text: const Text('Update Product Prices'),
              onPressed: () {
                cntx.router.navigate(
                  PricelistWrapper(
                    children: [
                      PricelistRowRoute(
                        pricelistModel: dataGridCell.value,
                        refresh: handleRefresh,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType == String
            ? SelectableText(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}

class TableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Code", "width": double.nan},
    "description": {"name": "Description", "width": double.nan},
  };

  static DataGridRow dataGrid(PaymentTermModel paytermObj) {
    return DataGridRow(
      cells: [
        DataGridCell<String>(
          columnName: columnName["code"]["name"],
          value: paytermObj.code,
        ),
        DataGridCell<String>(
          columnName: columnName["description"]["name"],
          value: paytermObj.description,
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
