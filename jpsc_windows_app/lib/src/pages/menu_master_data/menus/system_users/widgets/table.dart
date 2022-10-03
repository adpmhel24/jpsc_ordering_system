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
import 'assigned_branch.dart';
import 'table_settings.dart';

class SystemUsersTable extends StatefulWidget {
  const SystemUsersTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;

  @override
  State<SystemUsersTable> createState() => _SystemUsersTableState();
}

class _SystemUsersTableState extends State<SystemUsersTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  @override
  void initState() {
    super.initState();
  }

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<SystemUsersBloc, SystemUsersBlocState>(
        builder: (context, state) {
          _dataSource = DataSource(
            context,
            systemUsers: state.systemUsers,
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
              columns: SystemUsersTableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = SystemUsersTableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(() {
                  column["width"] = details.width;
                });

                return true;
              },
              onCellDoubleTap: (
                details,
              ) async {
                // DataGridRow selectedRow = _dataSource.effectiveRows
                //     .elementAt(details.rowColumnIndex.rowIndex - 1);
                // print(selectedRow.getCells()[0].value.email);
              },
            ),
          );
  }

  SizedBox tableFooter(SystemUsersBlocState state) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: state.systemUsers.isEmpty
            ? 1
            : (state.systemUsers.length / _rowsPerPage) +
                ((state.systemUsers.length % _rowsPerPage) > 0 ? 1 : 0),
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
  List<SystemUserModel> systemUsers;
  late List<SystemUserModel> paginatedSystemUsers;
  int startIndex;
  int endIndex;
  int rowsPerPage;
  List<DataGridRow> dataGridRows = [];

  DataSource(
    this.cntx, {
    required this.systemUsers,
    required this.startIndex,
    required this.endIndex,
    required this.rowsPerPage,
  }) {
    if (systemUsers.length < endIndex) {
      endIndex = systemUsers.length;
    }
    paginatedSystemUsers =
        systemUsers.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = paginatedSystemUsers.map((systemUser) {
      return SystemUsersTableSettings.dataGrid(systemUser);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * rowsPerPage;
    endIndex = startIndex + rowsPerPage;
    if (startIndex < systemUsers.length && endIndex <= systemUsers.length) {
      paginatedSystemUsers =
          systemUsers.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < systemUsers.length &&
        endIndex > systemUsers.length) {
      paginatedSystemUsers = systemUsers
          .getRange(startIndex, systemUsers.length)
          .toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else {
      paginatedSystemUsers = [];
    }

    return true;
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<SystemUsersBloc>().add(LoadSystemUsers());
    buildPaginatedDataGridRows();
    notifyListeners();
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'Email') {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(Constant.minPadding),
            child: Row(
              children: [
                m.Material(
                  child: m.InkWell(
                    onTap: () {
                      cntx.router.navigate(
                        SystemUsersWrapper(
                          children: [
                            SystemUserUpdateFormRoute(
                              selectedSystemUser: dataGridCell.value,
                            )
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
                Flexible(child: Text(dataGridCell.value.email)),
              ],
            ),
          );
        } else if (dataGridCell.columnName == 'Assigned Branch') {
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
                text: const Text('Update'),
                onPressed: () {
                  showDialog(
                    context: cntx,
                    builder: (_) => AssignedBranchModal(
                      assignedBranches: dataGridCell.value!,
                      handleRefresh: handleRefresh,
                    ),
                  );
                },
              ),
            ],
          );
        }
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(Constant.minPadding),
          child: dataGridCell.value.runtimeType != Icon
              ? Text(dataGridCell.value.toString())
              : dataGridCell.value,
        );
      }).toList(),
    );
  }
}
