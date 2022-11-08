import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jpsc_windows_app/src/router/router.gr.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';
import '../blocs/fetching_pricelists/bloc.dart';

class PricelistHeaderTable extends StatefulWidget {
  const PricelistHeaderTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  @override
  State<PricelistHeaderTable> createState() => _PricelistTableState();
}

class _PricelistTableState extends State<PricelistHeaderTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<PricelistFetchingBloc, PricelistFetchingState>(
        buildWhen: (prev, curr) =>
            curr.status == FetchingStatus.unauthorized ||
            curr.status == FetchingStatus.success,
        builder: (context, state) {
          if (state.status == FetchingStatus.unauthorized) {
            return Center(
              child: Text(state.errorMessage),
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
                    tableFooter(state),
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

  SizedBox tableFooter(PricelistFetchingState state) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: state.datas.isEmpty
            ? 1
            : (state.datas.length / _rowsPerPage) +
                ((state.datas.length % _rowsPerPage) > 0 ? 1 : 0),
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
  List<PricelistModel> datas;
  late List<PricelistModel> paginatedDatas;
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
      return PricelistTableSettings.dataGrid(data);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<PricelistFetchingBloc>().add(LoadPricelist());
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
      if (dataGridCell.columnName == 'Code') {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(Constant.minPadding),
          child: Row(
            children: [
              m.Material(
                child: m.InkWell(
                  onTap: () {
                    final int dataRowIndex = dataGridRows.indexOf(row);

                    cntx.router.navigate(
                      PricelistWrapper(
                        children: [
                          PricelistFormRoute(
                            header: "Pricelist Edit Form",
                            refresh: handleRefresh,
                            selectedPricelist: paginatedDatas[dataRowIndex],
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
      } else if (dataGridCell.columnName == 'Action') {
        return Container(
          alignment: Alignment.center,
          child: DropDownButton(
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
                          pricelistCode: dataGridCell.value.code,
                          refresh: handleRefresh,
                        ),
                      ],
                    ),
                  );
                },
              ),
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

class PricelistTableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Code", "width": double.nan},
    "description": {"name": "Description", "width": double.nan},
    "isActive": {"name": "Active", "width": Constant.minPadding * 15},
    "action": {"name": "Action", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(PricelistModel data) {
    return DataGridRow(
      cells: [
        DataGridCell(columnName: columnName["code"]["name"], value: data.code),
        DataGridCell(
            columnName: columnName["description"]["name"],
            value: data.description),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: data.isActive!
              ? const Icon(FluentIcons.check_mark)
              : Icon(
                  FluentIcons.status_circle_error_x,
                  color: Colors.red.light,
                ),
        ),
        DataGridCell(
          columnName: columnName["action"]["name"],
          value: data,
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
