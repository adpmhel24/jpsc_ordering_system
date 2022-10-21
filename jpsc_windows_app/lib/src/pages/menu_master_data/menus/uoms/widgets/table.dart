import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../global_blocs/blocs.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';
import '../../../../../utils/responsive.dart';
import 'table_settings.dart';

class UomsTable extends StatefulWidget {
  const UomsTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  @override
  State<UomsTable> createState() => _UomsTableState();
}

class _UomsTableState extends State<UomsTable> {
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
      child: BlocBuilder<UomsBloc, UomsBlocState>(
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
              datas: state.uoms,
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
              columns: UomsTableSettings.columns,
              columnWidthMode: Responsive.isMobile(context)
                  ? ColumnWidthMode.auto
                  : ColumnWidthMode.fill,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = UomsTableSettings.columnName.values
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

  SizedBox tableFooter(UomsBlocState state) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: state.uoms.isEmpty
            ? 1
            : (state.uoms.length / _rowsPerPage) +
                ((state.uoms.length % _rowsPerPage) > 0 ? 1 : 0),
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
  List<UomModel> datas;
  late List<UomModel> paginatedDatas;
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
      return UomsTableSettings.dataGrid(data);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<UomsBloc>().add(LoadUoms());
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
                    cntx.router.navigate(
                      UomsWrapper(
                        children: [
                          UomCreateRoute(
                            header: "UoM Update Form",
                            selectedUom: dataGridCell.value,
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
              Flexible(child: SelectableText(dataGridCell.value.code)),
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
