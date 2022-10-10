import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';

class BranchesTableSettings {
  static Map<String, dynamic> columnName = {
    "code": {"name": "Code", "width": double.nan},
    "description": {"name": "Description", "width": double.nan},
    "pricelist_code": {"name": "Pricelist Code", "width": double.nan},
    "isActive": {"name": "Active", "width": Constant.minPadding * 15},
    "action": {"name": "Action", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(BranchModel branchModel) {
    return DataGridRow(
      cells: [
        DataGridCell(
          columnName: columnName["code"]["name"],
          value: branchModel,
        ),
        DataGridCell(
          columnName: columnName["description"]["name"],
          value: branchModel.description,
        ),
        DataGridCell(
          columnName: columnName["pricelist_code"]["name"],
          value: branchModel.pricelistCode ?? "",
        ),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: branchModel.isActive
              ? const Icon(FluentIcons.check_mark)
              : Icon(
                  FluentIcons.status_circle_error_x,
                  color: Colors.red.light,
                ),
        ),
        DataGridCell(
          columnName: columnName["action"]["name"],
          value: branchModel.pricelist,
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
