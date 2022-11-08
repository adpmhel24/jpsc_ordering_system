import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/repositories/repos.dart';
import '../../../../../../shared/widgets/bordered_text.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../utils/constant.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../../../utils/responsive.dart';
import 'details_table.dart';

class InvAdjustmentOutDetailsPage extends StatelessWidget {
  const InvAdjustmentOutDetailsPage({
    Key? key,
    required this.header,
    required this.id,
  }) : super(key: key);

  final String header;
  final int id;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
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
        title: Text(header),
      ),
      content: AdjOutDetailsBody(
        id: id,
      ),
    );
  }
}

class AdjOutDetailsBody extends StatelessWidget {
  const AdjOutDetailsBody({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<InvAdjustmentOutRepo>().getDetails(fk: id),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Center(
              child: ProgressRing(),
            );
          case ConnectionState.done:
            return LayoutBuilder(
              builder: (_, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Responsive.isDesktop(context)
                          ? constraints.maxWidth * .5
                          : constraints.maxWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flex(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            direction: Responsive.isMobile(context)
                                ? Axis.vertical
                                : Axis.horizontal,
                            children: [
                              Flexible(
                                flex: 2,
                                child: InfoLabel(
                                  label: "Posting Date",
                                  child: BorderedText(
                                    child: SelectableText(
                                      dateFormatter(snapshot.data!.transdate),
                                      toolbarOptions: const ToolbarOptions(
                                          copy: true, selectAll: true),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InfoLabel(
                                      label: "Id",
                                      child: BorderedText(
                                        child: SelectableText(
                                            snapshot.data?.id.toString() ?? "",
                                            toolbarOptions:
                                                const ToolbarOptions(
                                                    copy: true,
                                                    selectAll: true)),
                                      ),
                                    ),
                                    Constant.heightSpacer,
                                    InfoLabel(
                                      label: "Reference",
                                      child: BorderedText(
                                        child: SelectableText(
                                          snapshot.data?.reference ?? "",
                                          toolbarOptions: const ToolbarOptions(
                                            copy: true,
                                            selectAll: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Constant.heightSpacer,
                          InfoLabel(
                            label: "Remarks",
                            child: BorderedText(
                              child: SelectableText(
                                snapshot.data?.remarks ?? "",
                                minLines: 2,
                                maxLines: 5,
                                toolbarOptions: const ToolbarOptions(
                                    copy: true, selectAll: true),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Constant.heightSpacer,
                    Expanded(
                        child: DetailsTable(
                      itemRows: snapshot.data!.rows,
                    )),
                    Constant.heightSpacer,
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: CustomFilledButton(
                        onPressed: () {
                          context.router.pop();
                        },
                        child: const Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          default:
            return const SizedBox.expand();
        }
      },
    );
  }
}
