import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';

import '../../../../../global_blocs/blocs.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/currency_formater.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../widgets/custom_dialog.dart';

part 'pq_datasource.dart';

class PriceQuotationHeaderTable extends StatefulWidget {
  const PriceQuotationHeaderTable({
    Key? key,
    required this.sfDataGridKey,
    required this.docStatus,
    required this.pqStatus,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  final String docStatus;
  final int? pqStatus;
  final String fromDate;
  final String toDate;

  @override
  State<PriceQuotationHeaderTable> createState() =>
      _PriceQuotationHeaderTableState();
}

class _PriceQuotationHeaderTableState extends State<PriceQuotationHeaderTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<FetchingPriceQuotationHeaderBloc,
          FetchingPriceQuotationHeaderState>(
        bloc: context.read<FetchingPriceQuotationHeaderBloc>(),
        buildWhen: (prev, curr) => prev.datas != curr.datas,
        builder: (context, state) {
          _dataSource = DataSource(
            context,
            onRefresh: () {
              context.read<FetchingPriceQuotationHeaderBloc>().add(
                    FetchAllPriceQuotationHeader(
                      docStatus: widget.docStatus,
                      pqStatus: widget.pqStatus,
                      fromDate: widget.fromDate,
                      toDate: widget.toDate,
                    ),
                  );
            },
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
              frozenColumnsCount: 2,
              columns: TableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onQueryRowHeight: (details) {
                return details.getIntrinsicRowHeight(details.rowIndex);
              },
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = TableSettings.columnName.values
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

  SizedBox tableFooter(int dataLength) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: dataLength == 0
            ? 1
            : (dataLength / _rowsPerPage) +
                ((dataLength % _rowsPerPage) > 0 ? 1 : 0),
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