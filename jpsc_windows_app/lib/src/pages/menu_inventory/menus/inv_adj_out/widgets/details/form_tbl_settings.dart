import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../data/models/models.dart';

class TableSettings {
  static Map<String, dynamic> columnName = {
    "item_code": {"name": "Item Code", "width": double.nan},
    "item_description": {"name": "Item Description", "width": double.nan},
    "quantity": {"name": "Quantity", "width": double.nan},
    "whsecode": {"name": "Warehouse", "width": double.nan},
    "uom": {"name": "UoM", "width": double.nan},
  };

  static DataGridRow dataGrid(
      BuildContext context, int index, InventoryAdjustmentOutRow data) {
    return DataGridRow(
      cells: [
        DataGridCell(
            columnName: columnName["item_code"]["name"], value: data.itemCode),
        DataGridCell(
            columnName: columnName["item_description"]["name"],
            value: data.itemDescription),
        DataGridCell(
            columnName: columnName["quantity"]["name"], value: data.quantity),
        DataGridCell(
          columnName: columnName["whsecode"]["name"],
          value: data.whsecode,
        ),
        DataGridCell(
          columnName: columnName["uom"]["name"],
          value: data.uom,
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
