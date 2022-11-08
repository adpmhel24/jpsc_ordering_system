import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/pricelist/widgets/pricelist_r_table.dart';
import 'package:jpsc_windows_app/src/utils/fetching_status.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_blocs/blocs.dart';
import '../../../../utils/constant.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import 'blocs/fetching_pricelistRow_bloc/bloc.dart';

class PricelistRowPage extends StatelessWidget {
  const PricelistRowPage({
    Key? key,
    this.pricelistCode,
    this.itemCode,
    required this.refresh,
  }) : super(key: key);

  final String? pricelistCode;
  final String? itemCode;
  final Future<void> Function() refresh;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PricelistRowsUpdateBloc(context.read<PricelistRepo>()),
        ),
        BlocProvider(
          create: (context) => FetchingPriceListRowBloc(
            pricelistRepo: context.read<PricelistRepo>(),
            objectTypeRepo: context.read<ObjectTypeRepo>(),
            currUserRepo: context.read<CurrentUserRepo>(),
          )..add(pricelistCode != null
              ? LoadPricelistRowByPricelistCode(pricelistCode!)
              : LoadPricelistRowByItemCode(itemCode ?? "")),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PricelistRowsUpdateBloc, PricelistRowsUpdateState>(
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
          ),
          BlocListener<FetchingPriceListRowBloc, FetchingPriceListRowState>(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status == FetchingStatus.loading) {
                context.loaderOverlay.show();
              } else if (state.status == FetchingStatus.error) {
                context.loaderOverlay.hide();
                CustomDialogBox.errorMessage(context, message: state.message);
              } else if (state.status == FetchingStatus.success ||
                  state.status == FetchingStatus.unauthorized) {
                context.loaderOverlay.hide();
              }
            },
          ),
        ],
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
            title: SelectableText(
                pricelistCode ?? "Update '$itemCode' Pricelists"),
          ),
          content:
              BlocBuilder<FetchingPriceListRowBloc, FetchingPriceListRowState>(
            builder: (context, state) {
              if (state.status == FetchingStatus.unauthorized) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.status == FetchingStatus.success) {
                return PricelistRowBody(
                  pricelistRows: state.datas,
                );
              }
              return const SizedBox.expand();
            },
          ),
        ),
      ),
    );
  }
}

class PricelistRowBody extends StatefulWidget {
  const PricelistRowBody({
    Key? key,
    required this.pricelistRows,
  }) : super(key: key);

  final List<PricelistRowModel> pricelistRows;

  @override
  State<PricelistRowBody> createState() => _PricelistRowBodyState();
}

class _PricelistRowBodyState extends State<PricelistRowBody> {
  late ValueNotifier<List<PricelistRowModel>> pricelistRows =
      ValueNotifier(widget.pricelistRows);

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
                pricelistRows.value = widget.pricelistRows;
              } else {
                pricelistRows.value = widget.pricelistRows
                    .where(
                      (pricelistRow) =>
                          pricelistRow.itemCode.toLowerCase().contains(
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
            CustomDialogBox.warningMessage(
              context,
              message: "Are you sure want you update?",
              onPositiveClick: (_) {
                context.read<PricelistRowsUpdateBloc>().add(
                      UpdateSubmitted(
                        items: widget.pricelistRows
                            .map((e) => e.toJson())
                            .toList(),
                      ),
                    );
              },
            );
          },
        ),
      ],
    );
  }
}
