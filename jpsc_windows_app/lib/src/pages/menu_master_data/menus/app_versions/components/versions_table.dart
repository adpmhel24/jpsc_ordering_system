import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/app_versions/blocs/fetching_versions_bloc/bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';

class AppVersionsTable extends StatefulWidget {
  const AppVersionsTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;

  @override
  State<AppVersionsTable> createState() => _AppVersionsTableState();
}

class _AppVersionsTableState extends State<AppVersionsTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page
  List<int> availableRowsPerPage = [10, 20, 50, 100];

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<FetchingAppVersionsBloc, FetchingAppVersionsState>(
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
              allowMultiColumnSorting: true,
              allowFiltering: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: TableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onQueryRowHeight: (details) {
                return details.getIntrinsicRowHeight(details.rowIndex);
              },
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.tableColumns
                    .firstWhere((e) => e.name == details.column.columnName);
                setState(() {
                  column.width = details.width;
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
        availableRowsPerPage: availableRowsPerPage.contains(dataLength)
            ? availableRowsPerPage
            : [...availableRowsPerPage, dataLength],
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
  List<AppVersionModel> datas;
  late List<AppVersionModel> paginatedDatas;
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
    dataGridRows = paginatedDatas.map((e) {
      return TableSettings.dataGrid(e);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<FetchingAppVersionsBloc>().add(LoadAppVersions());
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
                    // cntx.router.navigate(
                    //   BranchesWrapper(
                    //     children: [
                    //       BranchCreateRoute(
                    //           header: "Branch Update Form",
                    //           selectedBranch: dataGridCell.value,
                    //           onRefresh: () {
                    //             cntx
                    //                 .read<FetchingBranchesBloc>()
                    //                 .add(LoadBranches());
                    //           }),
                    //     ],
                    //   ),
                    // );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/sm_right_arrow.svg",
                    color: Colors.green,
                  ),
                ),
              ),
              Flexible(child: CopyButton(value: dataGridCell.value.toString())),
            ],
          ),
        );
      } else if (dataGridCell.columnName == 'Action') {
        return Container(
          alignment: Alignment.center,
          child: DropDownButton(
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
      } else if (dataGridCell.columnName == "Is Active") {
        return Container(
          alignment: Alignment.center,
          child: dataGridCell.value
              ? const Icon(FluentIcons.check_mark)
              : Icon(
                  FluentIcons.status_circle_error_x,
                  color: Colors.red.light,
                ),
        );
      }
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(5.0),
        child: dataGridCell.value.runtimeType != Icon
            ? CopyButton(value: dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}

class TableSettings {
  static final tableColumns = [
    ColumnModel(name: "Id", width: double.nan),
    ColumnModel(name: "Platform", width: double.nan),
    ColumnModel(name: "App Name", width: double.nan),
    ColumnModel(name: "Package Name", width: double.nan),
    ColumnModel(name: "Version", width: double.nan),
    ColumnModel(name: "Build Number", width: double.nan),
    ColumnModel(name: "Link", width: double.nan),
    ColumnModel(name: "Is Active", width: double.nan),
  ];

  static DataGridRow dataGrid(AppVersionModel data) {
    return DataGridRow(
      cells: [
        DataGridCell(
          columnName: tableColumns[0].name,
          value: data.id,
        ),
        DataGridCell(
          columnName: tableColumns[1].name,
          value: data.platform,
        ),
        DataGridCell(
          columnName: tableColumns[2].name,
          value: data.appName,
        ),
        DataGridCell(
          columnName: tableColumns[3].name,
          value: data.packageName,
        ),
        DataGridCell(
          columnName: tableColumns[4].name,
          value: data.version,
        ),
        DataGridCell(
          columnName: tableColumns[5].name,
          value: data.buildNumber,
        ),
        DataGridCell(
          columnName: tableColumns[6].name,
          value: data.link,
        ),
        DataGridCell<bool>(
          columnName: tableColumns[7].name,
          value: data.isActive,
        ),
      ],
    );
  }

  static List<GridColumn> get columns {
    return tableColumns.map(
      (e) {
        return GridColumn(
          width: e.width,
          columnName: e.name,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              e.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    ).toList();
  }
}

class ColumnModel {
  final String name;
  double width;

  ColumnModel({
    required this.name,
    required this.width,
  });
}
