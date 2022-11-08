import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/bulk_insert_bloc/bloc.dart';

class ProductBulkInsertPage extends StatefulWidget {
  const ProductBulkInsertPage(
      {Key? key, required this.datas, required this.onRefresh})
      : super(key: key);

  final List<CreateProductModel> datas;
  final VoidCallback onRefresh;
  @override
  State<ProductBulkInsertPage> createState() => _ProductBulkInsertPageState();
}

class _ProductBulkInsertPageState extends State<ProductBulkInsertPage> {
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
      title: const Text("Products to Upload"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBulkInsertBloc(context.read<ProductRepo>()),
      child: BlocListener<ProductBulkInsertBloc, ProductBulkInsertState>(
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
                        context.read<ProductBulkInsertBloc>().add(
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
                                  DataCell(Text(e.description ?? "")),
                                  DataCell(Text(e.saleUomCode ?? "")),
                                  DataCell(Text(e.itemGroupCode ?? "")),
                                  DataCell(Text(e.barcode ?? "")),
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
