import 'package:fluent_ui/fluent_ui.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';

class ItemsTableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Code", "width": double.nan},
    "description": {"name": "Description", "width": double.nan},
    "item_group_code": {"name": "Item Group Code", "width": double.nan},
    "sale_uom_code": {"name": "Sale UoM Code", "width": double.nan},
    "isActive": {"name": "Active", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(ProductModel item) {
    return DataGridRow(
      cells: [
        DataGridCell(columnName: columnName["code"]["name"], value: item),
        DataGridCell(
            columnName: columnName["description"]["name"],
            value: item.description),
        DataGridCell(
          columnName: columnName["item_group_code"]["name"],
          value: item.itemGroupCode,
        ),
        DataGridCell(
          columnName: columnName["sale_uom_code"]["name"],
          value: item.saleUomCode,
        ),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: item.isActive
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
