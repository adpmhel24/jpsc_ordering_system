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
import 'table_settings.dart';

class ItemsTable extends StatefulWidget {
  const ItemsTable({
    Key? key,
    required this.sfDataGridKey,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  @override
  State<ItemsTable> createState() => _ItemsTableState();
}

class _ItemsTableState extends State<ItemsTable> {
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
      child: BlocBuilder<ItemsBloc, ItemsBlocState>(
        builder: (context, state) {
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
              columns: ItemsTableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = ItemsTableSettings.columnName.values
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

  SizedBox tableFooter(ItemsBlocState state) {
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
  List<ProductModel> datas;
  late List<ProductModel> paginatedDatas;
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
    dataGridRows = paginatedDatas.map((whse) {
      return ItemsTableSettings.dataGrid(whse);
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    cntx.read<ItemsBloc>().add(LoadItems());
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
                      ItemWrapper(
                        children: [
                          ItemCreatePage(
                            header: "Item Edit Form",
                            selectedItem: dataGridCell.value,
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
