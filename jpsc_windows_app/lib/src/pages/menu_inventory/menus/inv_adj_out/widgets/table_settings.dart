import 'package:auto_route/auto_route.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../../shared/enums/docstatus.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../bloc/inv_adj_out_bloc.dart';

class InvAdjustmentTableSettings {
  static Map<String, dynamic> columnName = {
    "id": {"name": "Id", "width": double.nan},
    "reference": {"name": "Reference", "width": double.nan},
    "transDate": {"name": "Posting Date", "width": double.nan},
    "remarks": {"name": "Remarks", "width": double.nan},
    "createdBy": {"name": "Created By", "width": double.nan},
    "updatedBy": {"name": "Updated By", "width": double.nan},
    "action": {"name": "Action", "width": 80.0}
  };

  static DataGridRow dataGrid(
      BuildContext context, InventoryAdjustmentOutModel invAdjIn) {
    return DataGridRow(
      cells: [
        DataGridCell(columnName: columnName["id"]["name"], value: invAdjIn.id),
        DataGridCell(
            columnName: columnName["reference"]["name"],
            value: invAdjIn.reference),
        DataGridCell(
          columnName: columnName["transDate"]["name"],
          value: dateFormatter(invAdjIn.transdate),
        ),
        DataGridCell(
          columnName: columnName["remarks"]["name"],
          value: invAdjIn.remarks,
        ),
        DataGridCell(
          columnName: columnName["createdBy"]["name"],
          value: invAdjIn.createdBy.email,
        ),
        DataGridCell(
          columnName: columnName["updatedBy"]["name"],
          value: invAdjIn.updatedBy?.email ?? "",
        ),
        DataGridCell(
          columnName: columnName["action"]["name"],
          value: DropDownButton(
            disabled: (invAdjIn.docstatus == DocStatus.canceled),
            leading: const Icon(
              FluentIcons.settings,
              size: 15,
            ),
            items: [
              MenuFlyoutItem(
                leading: const Icon(
                  FluentIcons.delete,
                  size: 15,
                ),
                text: const Text('Cancel'),
                onPressed: () => CustomDialogBox.warningWithRemarks(
                  context,
                  message: "Are you sure you want to cancel this transaction?",
                  onPositiveClick: (cntx, remarks) {
                    context.read<InvAdjustmentOutBloc>().add(CancelInAdjOut(
                        id: invAdjIn.id, canceledRemarks: remarks));
                    cntx.router.pop();
                  },
                ),
              ),
            ],
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
