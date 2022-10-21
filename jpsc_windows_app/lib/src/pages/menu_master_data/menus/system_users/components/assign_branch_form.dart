import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';

class AssignedBranchModal extends StatefulWidget {
  const AssignedBranchModal({
    Key? key,
    required this.assignedBranches,
    required this.handleRefresh,
  }) : super(key: key);

  final List<SystemUserBranchModel> assignedBranches;
  final VoidCallback handleRefresh;

  @override
  State<AssignedBranchModal> createState() => _AssignedBranchModalState();
}

class _AssignedBranchModalState extends State<AssignedBranchModal> {
  late List<SystemUserBranchModel> _branches = [];

  @override
  void initState() {
    _branches = widget.assignedBranches
        .map((e) => SystemUserBranchModel.fromJson(json.decode(json.encode(e))))
        .toList();
    _branches.sort(((a, b) {
      if (b.isAssigned) {
        return 1;
      } else {
        return -1;
      }
    }));

    super.initState();
  }

  Future<void> update() async {
    context.loaderOverlay.show();
    try {
      String message = await context
          .read<SystemUserBranchRepo>()
          .updateAssignedBranch(
              datas: _branches.map((e) => e.toJson()).toList());
      context.loaderOverlay.hide();
      success(message);
    } on HttpException catch (e) {
      context.loaderOverlay.hide();
      error(e.message);
    }
  }

  void success(message) {
    CustomDialogBox.successMessage(context, message: message,
        onPositiveClick: (cntx) {
      widget.handleRefresh();
      cntx.router.pop();
    });
  }

  void error(message) {
    CustomDialogBox.errorMessage(
      context,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      return ContentDialog(
        title: const Text("Assigned Branches"),
        actions: [
          closeButton(),
          updateButton(),
        ],
        content: SizedBox(
          height: Responsive.isMobile(context) ? maxHeight : maxHeight * .75,
          width: Responsive.isMobile(context) ? maxWidth : 350,
          child: ListView.builder(
            itemCount: _branches.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  checked: _branches[index].isAssigned,
                  onChanged: (value) =>
                      setState(() => _branches[index].isAssigned = value!),
                ),
                title: Text(_branches[index].branchCode),
              );
            },
          ),
        ),
      );
    });
  }

  Button closeButton() {
    return Button(
        child: const Text("Close"), onPressed: () => context.router.pop());
  }

  FilledButton updateButton() {
    return FilledButton(
      child: const Text("Update"),
      onPressed: () {
        CustomDialogBox.warningMessage(context,
            message: "Are you sure you want to proceed?",
            onPositiveClick: (cntx) {
          update();
          cntx.router.pop();
        });
      },
    );
  }
}
