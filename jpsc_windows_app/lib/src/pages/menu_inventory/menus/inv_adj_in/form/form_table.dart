import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import 'bloc/bloc.dart';
import 'form_tbl_settings.dart';

part 'form_datasource.dart';

class InvAdjustmentInRowsFormTable extends StatefulWidget {
  const InvAdjustmentInRowsFormTable({
    Key? key,
  }) : super(key: key);

  @override
  State<InvAdjustmentInRowsFormTable> createState() =>
      _InvAdjustmentInRowsFormTableState();
}

class _InvAdjustmentInRowsFormTableState
    extends State<InvAdjustmentInRowsFormTable> {
  late DataSource _dataSource;
  late int _rowsPerPage = 10;
  final int _startIndex = 0;
  final int _endIndex = 10; // this should be equal to itemRows per page

  @override
  void initState() {
    super.initState();
  }

  final double _dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<InvAdjustmentInFormBloc, InvAdjustmentInFormState>(
        buildWhen: (previous, current) => previous.itemRows != current.itemRows,
        builder: (context, state) {
          _dataSource = DataSource(
            context,
            itemRows: state.itemRows,
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
              source: _dataSource,
              navigationMode: GridNavigationMode.cell,
              allowColumnsResizing: true,
              columns: FormTableSettings.columns,
              columnWidthMode: Responsive.isMobile(context)
                  ? ColumnWidthMode.auto
                  : ColumnWidthMode.fill,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                var column = FormTableSettings.columnName.values
                    .firstWhere((e) => e['name'] == details.column.columnName);
                setState(() {
                  column["width"] = details.width;
                });
                return true;
              },
            ),
          );
  }

  SizedBox tableFooter(InvAdjustmentInFormState state) {
    return SizedBox(
      height: _dataPagerHeight,
      child: SfDataPager(
        delegate: _dataSource,
        pageCount: state.itemRows.isEmpty
            ? 1
            : (state.itemRows.length / _rowsPerPage) +
                ((state.itemRows.length % _rowsPerPage) > 0 ? 1 : 0),
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
