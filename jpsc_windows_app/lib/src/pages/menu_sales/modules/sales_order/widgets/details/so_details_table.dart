// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/data/models/sales_order/model.dart';
import 'package:jpsc_windows_app/src/utils/currency_formater.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../data/models/sales_order/row_model.dart';
import '../../../../../../global_blocs/bloc_sales_order/update_bloc/bloc.dart';
import '../../../../../../utils/constant.dart';

part 'so_datasource.dart';

class DetailsTable extends StatefulWidget {
  const DetailsTable({
    Key? key,
    required this.itemRows,
  }) : super(key: key);

  final List<SalesOrderRowModel> itemRows;
  @override
  State<DetailsTable> createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to itemRows per page

  @override
  void initState() {
    _dataSource = DataSource(
      context,
      itemRows: widget.itemRows,
      startIndex: _startIndex,
      endIndex: _endIndex,
      rowsPerPage: _rowsPerPage,
    );
    super.initState();
  }

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              tableBody(constraint),
              tableFooter(),
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
              allowEditing: true,
              editingGestureType: EditingGestureType.doubleTap,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              columns: TableSettings.columns,
              columnWidthMode: ColumnWidthMode.fill,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(
                  () {
                    column["width"] = details.width;
                  },
                );
                return true;
              },
            ),
          );
  }

  SizedBox tableFooter() {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: widget.itemRows.isEmpty
            ? 1
            : (widget.itemRows.length / _rowsPerPage) +
                ((widget.itemRows.length % _rowsPerPage) > 0 ? 1 : 0),
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
