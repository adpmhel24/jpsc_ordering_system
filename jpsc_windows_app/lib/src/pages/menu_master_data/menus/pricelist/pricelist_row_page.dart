import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/pricelist/widgets/pricelist_r_table.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_blocs/blocs.dart';
import '../../../../utils/constant.dart';
import '../../../widgets/custom_dialog.dart';

class PricelistRowPage extends StatelessWidget {
  const PricelistRowPage({
    Key? key,
    required this.pricelistModel,
    required this.refresh,
  }) : super(key: key);

  final PricelistModel pricelistModel;
  final Future<void> Function() refresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PricelistRowsUpdateBloc(context.read<PricelistRepo>()),
      child: BlocListener<PricelistRowsUpdateBloc, PricelistRowsUpdateState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();

            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(context, message: state.message,
                onPositiveClick: (cntx) async {
              cntx.router.pop(); // pop the dialog
              context.router.pop(); // pop the page
              await refresh();
            });
          }
        },
        child: ScaffoldPage.withPadding(
          header: PageHeader(
            leading: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.noWrap,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(
                      FluentIcons.back,
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                  ),
                ),
              ],
            ),
            title: Text("${pricelistModel.code}"),
          ),
          content: PricelistRowBody(
            pricelist: pricelistModel,
          ),
        ),
      ),
    );
  }
}

class PricelistRowBody extends StatefulWidget {
  const PricelistRowBody({Key? key, required this.pricelist}) : super(key: key);

  final PricelistModel pricelist;

  @override
  State<PricelistRowBody> createState() => _PricelistRowBodyState();
}

class _PricelistRowBodyState extends State<PricelistRowBody> {
  late ValueNotifier<List<PricelistRowModel>> pricelistRows =
      ValueNotifier(widget.pricelist.rows!);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: TextBox(
            suffix: const Icon(FluentIcons.search),
            placeholder: 'Search Item Code',
            onChanged: (value) {
              if (value.isEmpty) {
                pricelistRows.value = widget.pricelist.rows!;
              } else {
                pricelistRows.value = widget.pricelist.rows!
                    .where(
                      (pricelistRow) =>
                          pricelistRow.itemCode!.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                    )
                    .toList();
              }
            },
          ),
        ),
        Constant.heightSpacer,
        Expanded(
          child: ValueListenableBuilder<List<PricelistRowModel>>(
              valueListenable: pricelistRows,
              builder: (context, datas, wdgt) {
                return PricelistRowTable(
                  datas: datas,
                );
              }),
        ),
        Constant.heightSpacer,
        Button(
          child: const Text("Update"),
          onPressed: () {
            CustomDialogBox.warningMessage(context,
                message: "Are you sure want you update?",
                onPositiveClick: (cntx) {
              context.read<PricelistRowsUpdateBloc>().add(
                    UpdateSubmitted(
                      items: widget.pricelist.rows!
                          .map((e) => e.toJson())
                          .toList(),
                    ),
                  );
              cntx.router.pop();
            });
          },
        ),
      ],
    );
  }
}
