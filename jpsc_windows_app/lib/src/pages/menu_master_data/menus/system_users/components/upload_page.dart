import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/bulk_insert_bloc/bloc.dart';

class SystemUsersToUploadPage extends StatefulWidget {
  const SystemUsersToUploadPage(
      {Key? key, required this.datas, required this.onRefresh})
      : super(key: key);

  final List<CreateSystemUserModel> datas;
  final VoidCallback onRefresh;
  @override
  State<SystemUsersToUploadPage> createState() =>
      _SystemUserToUploadPageState();
}

class _SystemUserToUploadPageState extends State<SystemUsersToUploadPage> {
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  PageHeader _header(BuildContext context) {
    return PageHeader(
      leading: CommandBar(
        overflowBehavior: CommandBarOverflowBehavior.noWrap,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => w,
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.back),
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
        ],
      ),
      title: const Text("System Users To Upload"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SystemUserBulkInsertBloc(context.read<SystemUserRepo>()),
      child: BlocListener<SystemUserBulkInsertBloc, SystemUserBulkInsertState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(
              context,
              message: state.message,
              onPositiveClick: (_) {
                widget.onRefresh();
                context.router
                  ..pop()
                  ..pop();
              },
            );
          }
        },
        child: Builder(
          builder: (context) {
            return ScaffoldPage.withPadding(
              header: _header(context),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton(
                    child: const Text("Upload"),
                    onPressed: () {
                      CustomDialogBox.warningMessage(context,
                          message: "Are you sure you want to proceed?",
                          onPositiveClick: (cntx) {
                        context.read<SystemUserBulkInsertBloc>().add(
                              UploadButtonSubmitted(
                                widget.datas.map((e) => e.toJson()).toList(),
                              ),
                            );
                      });
                    },
                  ),
                  Constant.heightSpacer,
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _verticalScrollController,
                      physics: const BouncingScrollPhysics(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _horizontalScrollController,
                        child: m.DataTable(
                          sortAscending: true,
                          sortColumnIndex: 3,
                          columns: widget.datas[0]
                              .toJson()
                              .keys
                              .map((e) => m.DataColumn(label: Text(e)))
                              .toList(),
                          rows: widget.datas
                              .map(
                                (e) => m.DataRow(
                                  cells: [
                                    m.DataCell(Text(e.email)),
                                    m.DataCell(Text(e.firstName)),
                                    m.DataCell(Text(e.lastName)),
                                    m.DataCell(Icon(e.isActive
                                        ? FluentIcons.check_mark
                                        : FluentIcons.calculator_multiply)),
                                    m.DataCell(Icon(e.isSuperAdmin
                                        ? FluentIcons.check_mark
                                        : FluentIcons.calculator_multiply)),
                                    m.DataCell(Text(e.positionCode ?? "")),
                                    m.DataCell(Text(e.password)),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
