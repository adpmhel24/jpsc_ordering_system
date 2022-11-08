import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';

class SystemUsersTableSettings {
  static Map<String, dynamic> columnName = {
    "email": {"name": "Email", "width": double.nan},
    "firstName": {"name": "First Name", "width": double.nan},
    "lastName": {"name": "Last Name", "width": double.nan},
    "position": {"name": "Position", "width": double.nan},
    "assignedBranch": {
      "name": "Assigned Branch",
      "width": Constant.minPadding * 20
    },
    "authorizations": {
      "name": "Authorizations",
      "width": Constant.minPadding * 20
    },
    "itemGroupAuth": {
      "name": "Item Group Auth",
      "width": Constant.minPadding * 20
    },
    "isActive": {"name": "Active", "width": Constant.minPadding * 15},
  };

  static DataGridRow dataGrid(SystemUserModel systemUser) {
    return DataGridRow(
      cells: [
        DataGridCell(
            columnName: columnName["email"]["name"], value: systemUser.email),
        DataGridCell(
          columnName: columnName["firstName"]["name"],
          value: systemUser.firstName,
        ),
        DataGridCell(
          columnName: columnName["lastName"]["name"],
          value: systemUser.lastName,
        ),
        DataGridCell(
          columnName: columnName["position"]["name"],
          value: systemUser.positionCode,
        ),
        DataGridCell(
          columnName: columnName["assignedBranch"]["name"],
          value: systemUser.assignedBranch,
        ),
        DataGridCell(
          columnName: columnName["authorizations"]["name"],
          value: systemUser.authorizations,
        ),
        DataGridCell(
          columnName: columnName["itemGroupAuth"]["name"],
          value: systemUser.itemGroupAuth,
        ),
        DataGridCell(
          columnName: columnName["isActive"]["name"],
          value: systemUser.isActive
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
