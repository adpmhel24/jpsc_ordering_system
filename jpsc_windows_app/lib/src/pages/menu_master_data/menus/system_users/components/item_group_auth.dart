import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../utils/constant.dart';

class ItemGroupUserAuthDialog extends StatefulWidget {
  const ItemGroupUserAuthDialog({
    Key? key,
    required this.itemGroupAuth,
    required this.onRefresh,
  }) : super(key: key);

  final List<AuthItemGroupModel> itemGroupAuth;
  final VoidCallback onRefresh;

  @override
  State<ItemGroupUserAuthDialog> createState() =>
      _ItemGroupUserAuthDialogState();
}

class _ItemGroupUserAuthDialogState extends State<ItemGroupUserAuthDialog> {
  final TextEditingController _searchController = TextEditingController();
  late List<AuthItemGroupModel> dataToSubmit;
  ValueNotifier<List<AuthItemGroupModel>> itemGroupAuthNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    dataToSubmit = widget.itemGroupAuth
        .map((e) => AuthItemGroupModel.fromJson(e.toJson()))
        .toList();
    itemGroupAuthNotifier.value = widget.itemGroupAuth
        .map((e) => AuthItemGroupModel.fromJson(e.toJson()))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void updateDataToUpload(AuthItemGroupModel value) {
    int index = dataToSubmit.indexWhere((element) => element.id == value.id);
    dataToSubmit[index] = value;
  }

  void searchItemGroupCode(String value) {
    List<AuthItemGroupModel> tempItemGroupAuths;
    tempItemGroupAuths = dataToSubmit
        .where(
            (e) => e.itemGroupCode.toLowerCase().contains(value.toLowerCase()))
        .map((e) => AuthItemGroupModel.fromJson(e.toJson()))
        .toList();
    if (tempItemGroupAuths.isNotEmpty) {
      itemGroupAuthNotifier.value = tempItemGroupAuths;
    } else {
      itemGroupAuthNotifier.value = dataToSubmit
          .map((e) => AuthItemGroupModel.fromJson(e.toJson()))
          .toList();
    }
  }

  Future<void> onButtonSubmitted() async {
    context.loaderOverlay.show();
    ItemGroupAuthRepo repo = context.read<ItemGroupAuthRepo>();

    try {
      String message = await repo.bulkUpdate(
          datas: itemGroupAuthNotifier.value.map((e) => e.toJson()).toList());
      context.loaderOverlay.hide();
      if (mounted) {
        CustomDialogBox.successMessage(
          context,
          message: message,
          onPositiveClick: (cntx) {
            Navigator.of(context).pop();
            widget.onRefresh();
          },
        );
      }
    } on HttpException catch (e) {
      context.loaderOverlay.hide();
      CustomDialogBox.errorMessage(context, message: e.message);
    } on Exception catch (e) {
      context.loaderOverlay.hide();

      CustomDialogBox.errorMessage(context, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text(
        "Item Group Authorization",
        style: TextStyle(fontSize: 20.0),
      ),
      actions: [
        CustomButton(
          child: const Text("Closed"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CustomFilledButton(
          child: const Text("Update"),
          onPressed: () {
            CustomDialogBox.warningMessage(
              context,
              message: "Are you sure you want to proceed?",
              onPositiveClick: (cntx) async {
                await onButtonSubmitted();
              },
            );
          },
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormBox(
            controller: _searchController,
            textInputAction: TextInputAction.done,
            placeholder: "Type item group code and hit enter",
            onFieldSubmitted: (value) {
              searchItemGroupCode(value);
            },
            suffix: IconButton(
              icon: const Icon(FluentIcons.clear),
              onPressed: () {
                _searchController.clear();
                searchItemGroupCode("");
              },
            ),
          ),
          Constant.heightSpacer,
          Expanded(
            child: ValueListenableBuilder<List<AuthItemGroupModel>>(
              valueListenable: itemGroupAuthNotifier,
              builder: (_, items, __) => TreeView(
                selectionMode: TreeViewSelectionMode.multiple,
                shrinkWrap: true,
                includePartiallySelectedItems: true,
                deselectParentWhenChildrenDeselected: false,
                items: [
                  TreeViewItem(
                    content: const Text("Item Group Codes"),
                    onInvoked: (item, reason) async {
                      if (reason == TreeViewItemInvokeReason.selectionToggle) {
                        for (var e in items) {
                          e.grantAvgValue = item.selected!;
                          e.grantLastPurc = item.selected!;
                          updateDataToUpload(e);
                        }
                      }
                    },
                    children: items
                        .map(
                          (e) => TreeViewItem(
                            content: Text(e.itemGroupCode),
                            value: e,
                            onInvoked: (item, reason) async {
                              if (reason ==
                                  TreeViewItemInvokeReason.selectionToggle) {
                                e.grantLastPurc = item.selected!;
                                e.grantAvgValue = item.selected!;
                                updateDataToUpload(e);
                              }
                            },
                            children: [
                              TreeViewItem(
                                content: const Text("Last Purchased Price"),
                                selected: e.grantLastPurc,
                                onInvoked: (item, reason) async {
                                  if (reason ==
                                      TreeViewItemInvokeReason
                                          .selectionToggle) {
                                    e.grantLastPurc = item.selected!;
                                    updateDataToUpload(e);
                                  }
                                },
                              ),
                              TreeViewItem(
                                content: const Text("SAP Avg Value"),
                                selected: e.grantAvgValue,
                                onInvoked: (item, reason) async {
                                  if (reason ==
                                      TreeViewItemInvokeReason
                                          .selectionToggle) {
                                    e.grantAvgValue = item.selected!;
                                    updateDataToUpload(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
