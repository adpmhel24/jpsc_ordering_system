import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../global_blocs/blocs.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import 'table_settings.dart';

class BranchesTable extends StatefulWidget {
  const BranchesTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;

  @override
  State<BranchesTable> createState() => _BranchesTableState();
}

class _BranchesTableState extends State<BranchesTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<BranchesBloc, BranchesBlocState>(
        builder: (context, state) {
          _dataSource = DataSource(
            context,
            branches: state.branches,
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
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: BranchesTableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = BranchesTableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(() {
                  column["width"] = details.width;
                });

                return true;
              },
              // onCellDoubleTap: (
              //   details,
              // ) async {

              // },
            ),
          );
  }

  SizedBox tableFooter(BranchesBlocState state) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: state.branches.isEmpty
            ? 1
            : (state.branches.length / _rowsPerPage) +
                ((state.branches.length % _rowsPerPage) > 0 ? 1 : 0),
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
  List<BranchModel> branches;
  late List<BranchModel> paginatedBranches;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

  DataSource(
    this.cntx, {
    required this.branches,
    required this.startIndex,
    required this.endIndex,
    required this.rowsPerPage,
  }) {
    if (branches.length < endIndex) {
      endIndex = branches.length;
    }
    paginatedBranches =
        branches.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedBranches.map((branch) {
      return BranchesTableSettings.dataGrid(branch);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<BranchesBloc>().add(LoadBranches());
    buildPaginatedDataGridRows();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * rowsPerPage;
    endIndex = startIndex + rowsPerPage;
    if (startIndex < branches.length && endIndex <= branches.length) {
      paginatedBranches =
          branches.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < branches.length && endIndex > branches.length) {
      paginatedBranches = branches
          .getRange(startIndex, branches.length)
          .toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else {
      paginatedBranches = [];
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
                    cntx.router.navigate(
                      BranchesWrapper(
                        children: [
                          BranchCreateRoute(
                            header: "Branch Update Form",
                            selectedBranch: dataGridCell.value,
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
              Flexible(child: Text(dataGridCell.value.code)),
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
        child: dataGridCell.value.runtimeType != Icon
            ? Text(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}
