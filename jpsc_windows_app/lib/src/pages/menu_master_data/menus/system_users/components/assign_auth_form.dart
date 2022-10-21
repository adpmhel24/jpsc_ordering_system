import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../widgets/custom_dialog.dart';

class SystemUserAuthDialog extends StatefulWidget {
  const SystemUserAuthDialog({
    Key? key,
    required this.sysAuthsObj,
    required this.onRefresh,
    required this.authorizationRepo,
  }) : super(key: key);

  final List<AuthorizationModel> sysAuthsObj;
  final VoidCallback onRefresh;
  final AuthorizationRepo authorizationRepo;

  @override
  State<SystemUserAuthDialog> createState() => _SystemUserAuthState();
}

class _SystemUserAuthState extends State<SystemUserAuthDialog> {
  ValueNotifier<List<MenuGroupModel>> menuGroupsNotifier = ValueNotifier([]);

  late List<TreeViewItem> treeItems = [];

  late List<AuthorizationModel> sysAuthsObj;
  @override
  void initState() {
    sysAuthsObj = widget.sysAuthsObj
        .map((e) => AuthorizationModel.fromJson(e.toJson()))
        .toList();
    loadInitialDatas();
    super.initState();
  }

  void loadInitialDatas() async {
    final repo = context.read<MenuGroupRepo>();
    context.loaderOverlay.show();

    try {
      await repo.getAll();
      menuGroupsNotifier.value = repo.datas;
    } on HttpException catch (e) {
      CustomDialogBox.errorMessage(context, message: e.message);
    } on Exception catch (e) {
      CustomDialogBox.errorMessage(context, message: e.toString());
    }
    context.loaderOverlay.hide();
  }

  Future<void> updateAuthorizations() async {
    context.loaderOverlay.show();

    try {
      widget.authorizationRepo
          .bulkUpdate(datas: sysAuthsObj.map((e) => e.toJson()).toList());
    } on HttpException catch (e) {
      CustomDialogBox.errorMessage(context, message: e.message);
    } on Exception catch (e) {
      CustomDialogBox.errorMessage(context, message: e.toString());
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      actions: [
        Button(
            child: const Text("Closed"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        FilledButton(
          child: const Text("Update"),
          onPressed: () {
            CustomDialogBox.warningMessage(context,
                message: "Are you sure you want to proceed?",
                onPositiveClick: (cntx) async {
              Navigator.of(cntx)
                ..pop()
                ..pop();

              await updateAuthorizations();

              widget.onRefresh();
            });
          },
        )
      ],
      content: ValueListenableBuilder<List<MenuGroupModel>>(
        valueListenable: menuGroupsNotifier,
        builder: (context, menuGroups, _) {
          return TreeView(
            selectionMode: TreeViewSelectionMode.multiple,
            shrinkWrap: true,
            includePartiallySelectedItems: true,
            items: [
              TreeViewItem(
                content: const Text('Authorizations'),
                value: "Authorizations",
                // This means the item will be expandable, although there are no
                // children yet.
                lazy: true,
                // Ensure the list is modifiable.
                children: [],
                onExpandToggle: (item, getsExpanded) async {
                  // If it's already populated, return.
                  if (item.children.isNotEmpty) return;

                  await Future.delayed(const Duration(seconds: 1));
                  // ...and add the fetched nodes.
                  item.children.addAll(
                    menuGroups
                        .map(
                          (e) => TreeViewItem(
                              content: Text(e.code),
                              lazy: true,
                              value: e.code,
                              children: [],
                              onInvoked: (item, reason) async {
                                sysAuthsObj
                                    .where((auth) =>
                                        auth.objectTypeObj?.menuGroupCode ==
                                        e.code)
                                    .toList()
                                    .map((e) {
                                  e.full = item.selected!;
                                  e.create = item.selected!;
                                  e.read = item.selected!;
                                  e.update = item.selected!;
                                  e.approve = item.selected!;
                                });
                              },
                              onExpandToggle: (item, getsExpanded) async {
                                if (item.children.isNotEmpty) return;
                                item.children.addAll(
                                  sysAuthsObj
                                      .where((auth) =>
                                          auth.objectTypeObj?.menuGroupCode ==
                                          e.code)
                                      .toList()
                                      .map(
                                        (auth) => TreeViewItem(
                                            content: Text(
                                                auth.objectTypeObj?.name ?? ""),
                                            value: auth,
                                            lazy: true,
                                            onInvoked: (item, reason) async {
                                              if (reason ==
                                                  TreeViewItemInvokeReason
                                                      .selectionToggle) {
                                                AuthorizationModel authObj =
                                                    item.value;
                                                authObj.full = item.selected!;
                                                authObj.create = item.selected!;
                                                authObj.read = item.selected!;
                                                authObj.update = item.selected!;
                                                authObj.approve =
                                                    item.selected!;
                                              }
                                            },
                                            children: [
                                              TreeViewItem(
                                                content: const Text("Full"),
                                                selected: auth.full,
                                                onInvoked:
                                                    (item, reason) async {
                                                  if (reason ==
                                                      TreeViewItemInvokeReason
                                                          .selectionToggle) {
                                                    AuthorizationModel authObj =
                                                        item.parent!.value;
                                                    authObj.full =
                                                        item.selected!;
                                                  }
                                                },
                                              ),
                                              TreeViewItem(
                                                content: const Text("Create"),
                                                selected: auth.create,
                                                onInvoked:
                                                    (item, reason) async {
                                                  if (reason ==
                                                      TreeViewItemInvokeReason
                                                          .selectionToggle) {
                                                    AuthorizationModel authObj =
                                                        item.parent!.value;
                                                    authObj.create =
                                                        item.selected!;
                                                  }
                                                },
                                              ),
                                              TreeViewItem(
                                                content: const Text("Read"),
                                                selected: auth.read,
                                                onInvoked:
                                                    (item, reason) async {
                                                  if (reason ==
                                                      TreeViewItemInvokeReason
                                                          .selectionToggle) {
                                                    AuthorizationModel authObj =
                                                        item.parent!.value;
                                                    authObj.read =
                                                        item.selected!;
                                                  }
                                                },
                                              ),
                                              TreeViewItem(
                                                content: const Text("Update"),
                                                selected: auth.update,
                                                onInvoked:
                                                    (item, reason) async {
                                                  if (reason ==
                                                      TreeViewItemInvokeReason
                                                          .selectionToggle) {
                                                    AuthorizationModel authObj =
                                                        item.parent!.value;
                                                    authObj.update =
                                                        item.selected!;
                                                  }
                                                },
                                              ),
                                              TreeViewItem(
                                                content: const Text("Approve"),
                                                selected: auth.approve,
                                                onInvoked:
                                                    (item, reason) async {
                                                  if (reason ==
                                                      TreeViewItemInvokeReason
                                                          .selectionToggle) {
                                                    AuthorizationModel authObj =
                                                        item.parent!.value;
                                                    authObj.approve =
                                                        item.selected!;
                                                  }
                                                },
                                              ),
                                            ]),
                                      )
                                      .toList(),
                                );
                              }),
                        )
                        .toList(),
                  );
                },
              ),
            ],
            // onItemInvoked: (item, reason) async => item.selected = true,
            onSelectionChanged: (selectedItems) async {
              final topParent = selectedItems.map((i) {
                if (i.value == "Authorizations") {
                  return i;
                }
              });
              if (topParent.length == 1) {
                sysAuthsObj = sysAuthsObj
                    .where((auth) => auth.objectTypeObj?.menuGroupCode != null)
                    .toList()
                    .map((e) {
                  e.full = topParent.first!.selected!;
                  e.create = topParent.first!.selected!;
                  e.read = topParent.first!.selected!;
                  e.update = topParent.first!.selected!;
                  e.approve = topParent.first!.selected!;
                  return e;
                }).toList();
              } else if (topParent.isEmpty) {
                sysAuthsObj = sysAuthsObj
                    .where((auth) => auth.objectTypeObj?.menuGroupCode != null)
                    .toList()
                    .map((e) {
                  e.full = false;
                  e.create = false;
                  e.read = false;
                  e.update = false;
                  e.approve = false;
                  return e;
                }).toList();
              }
            },
          );
        },
      ),
    );
  }
}
