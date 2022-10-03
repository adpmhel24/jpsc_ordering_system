import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../router/router.gr.dart';
import '../../../../shared/enums/docstatus.dart';
import '../base_scaffold.dart';
import 'bloc/inv_adj_in_bloc.dart';
import 'widgets/table.dart';

class InvAdjustmentInPage extends StatefulWidget {
  const InvAdjustmentInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<InvAdjustmentInPage> createState() => _InvAdjustmentInPageState();
}

class _InvAdjustmentInPageState extends State<InvAdjustmentInPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvAdjustmentInBloc(
        context.read<InvAdjustmentInRepo>(),
      ),
      child: Builder(builder: (context) {
        return BaseInventoryScaffold(
            title: "Inventory Adjustment In",
            onNewButton: () {
              context.router.navigate(
                InvAdjInWrapper(
                  children: [
                    InvAdjustmentInCreateRoute(
                      header: "Inv Adjustment In Create Form",
                      invAdjInbloc: context.read<InvAdjustmentInBloc>(),
                    ),
                  ],
                ),
              );
            },
            onRefreshButton: () {
              sfDataGridKey.currentState!.refresh();
            },
            onFilter: (fromDate, toDate) {
              context
                  .read<InvAdjustmentInBloc>()
                  .add(FilterInvAdjIn(fromDate: fromDate, toDate: toDate));
            },
            tabs: [
              Tab(
                icon: const ImageIcon(
                  AssetImage('assets/icons/done_document.png'),
                ),
                text: const Text("Closed"),
                body: InvAdjInTable(
                  docStatus: DocStatus.closed,
                  sfDataGridKey: sfDataGridKey,
                ),
              ),
              Tab(
                icon: const ImageIcon(
                  AssetImage('assets/icons/delete_document.png'),
                ),
                text: const Text("Canceled"),
                body: InvAdjInTable(
                  docStatus: DocStatus.canceled,
                  sfDataGridKey: sfDataGridKey,
                ),
              ),
            ]);
      }),
    );
  }
}
