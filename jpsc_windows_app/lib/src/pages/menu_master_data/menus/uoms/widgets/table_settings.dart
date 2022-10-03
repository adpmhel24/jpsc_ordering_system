import 'package:fluent_ui/fluent_ui.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';

class UomsTableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Code", "width": double.nan},
    "description": {"name": "Description", "width": double.nan},
    "isActive": {"name": "Active", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(UomModel model) {
    return DataGridRow(
      cells: [
        DataGridCell(columnName: columnName["code"]["name"], value: model),
        DataGridCell(
            columnName: columnName["description"]["name"],
            value: model.description),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: model.isActive
              ? const Icon(FluentIcons.check_mark)
              : Icon(
                  FluentIcons.status_circle_error_x,
                  color: Colors.red.light,
                ),
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
