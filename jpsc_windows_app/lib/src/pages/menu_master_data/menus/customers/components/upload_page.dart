import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/bulk_insert_bloc/bloc.dart';

class CustomersBulkInsertPage extends StatefulWidget {
  const CustomersBulkInsertPage(
      {Key? key, required this.datas, required this.onRefresh})
      : super(key: key);

  final List<CustomerCreateModel> datas;
  final VoidCallback onRefresh;
  @override
  State<CustomersBulkInsertPage> createState() =>
      _CustomersBulkInsertPageState();
}

class _CustomersBulkInsertPageState extends State<CustomersBulkInsertPage> {
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
      title: const Text("Customers to Upload"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerBulkInsertBloc(context.read<CustomerRepo>()),
      child: BlocListener<CustomerBulkInsertBloc, CustomerBulkInsertState>(
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
                        context.read<CustomerBulkInsertBloc>().add(
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
                      child: DataTable(
                        columns: widget.datas[0]
                            .toJson()
                            .keys
                            .map((e) => DataColumn(label: Text(e)))
                            .toList(),
                        rows: widget.datas
                            .map(
                              (e) => DataRow(
                                cells: [
                                  DataCell(Text(e.code)),
                                  DataCell(Text(e.cardName ?? "")),
                                  DataCell(Text(e.location ?? "")),
                                  DataCell(Text(e.firstName ?? "")),
                                  DataCell(Text(e.middleInitial ?? "")),
                                  DataCell(Text(e.lastName ?? "")),
                                  DataCell(Text(e.contactNumber ?? "")),
                                  DataCell(Text(e.email ?? "")),
                                  DataCell(Text(e.paymentTerm ?? "")),
                                  DataCell(Text(e.creditLimit.toString())),
                                ],
                              ),
                            )
                            .toList(),
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
