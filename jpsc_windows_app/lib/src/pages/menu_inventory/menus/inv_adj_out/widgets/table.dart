import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../router/router.gr.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/fetching_status.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../bloc/inv_adj_out_bloc.dart';
import 'table_settings.dart';

part 'datasource.dart';

class InvAdjOutTable extends StatefulWidget {
  const InvAdjOutTable(
      {Key? key, required this.sfDataGridKey, required this.docStatus})
      : super(key: key);

  final GlobalKey<SfDataGridState> sfDataGridKey;
  final String docStatus;
  @override
  State<InvAdjOutTable> createState() => _InvAdjOutTableState();
}

class _InvAdjOutTableState extends State<InvAdjOutTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to rows per page

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocConsumer<InvAdjustmentOutBloc, InvAdjustmentOutBlocStates>(
        bloc: context.read<InvAdjustmentOutBloc>()
          ..add(FilterInvAdjOut(
            docStatus: widget.docStatus,
          )),
        buildWhen: (prev, curr) => prev.datas != curr.datas,
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (_, state) {
          if (state.status == FetchingStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == FetchingStatus.error) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status == FetchingStatus.success &&
              !state.isCanceled) {
            context.loaderOverlay.hide();
          } else if (state.isCanceled &&
              state.status == FetchingStatus.success) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(context, message: state.message,
                onPositiveClick: (cntx) {
              widget.sfDataGridKey.currentState!.refresh();
              // cntx.router.pop();
            });
          }
        },
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
              allowMultiColumnSorting: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              allowPullToRefresh: true,
              columns: InvAdjustmentTableSettings.columns,
              columnWidthMode: ColumnWidthMode.auto,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = InvAdjustmentTableSettings.columnName.values
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

  SizedBox tableFooter(InvAdjustmentOutBlocStates state) {
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
