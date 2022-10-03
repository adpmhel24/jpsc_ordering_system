import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../router/router.gr.dart';
import '../../../../shared/enums/docstatus.dart';
import '../base_scaffold.dart';
import 'bloc/inv_adj_out_bloc.dart';
import 'widgets/table.dart';

class InvAdjustmentOutPage extends StatefulWidget {
  const InvAdjustmentOutPage({Key? key}) : super(key: key);

  @override
  State<InvAdjustmentOutPage> createState() => _InvAdjustmentOutPageState();
}

class _InvAdjustmentOutPageState extends State<InvAdjustmentOutPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvAdjustmentOutBloc(
        context.read<InvAdjustmentOutRepo>(),
      ),
      child: Builder(builder: (context) {
        return BaseInventoryScaffold(
          title: "Inventory Adjustment Out",
          onNewButton: () {
            context.router.navigate(
              InvAdjOutWrapper(
                children: [
                  InvAdjustmentOutCreateRoute(
                    header: "Inv Adjustment Out Create Form",
                    invAdjOutbloc: context.read<InvAdjustmentOutBloc>(),
                  ),
                ],
              ),
            );
          },
          onRefreshButton: () {
            sfDataGridKey.currentState!.refresh();
          },
          onFilter: (fromDate, toDate) {
            context.read<InvAdjustmentOutBloc>().add(FilterInvAdjOut(
                  fromDate: fromDate,
                  toDate: toDate,
                ));
          },
          tabs: [
            Tab(
              icon: const ImageIcon(
                AssetImage('assets/icons/done_document.png'),
              ),
              text: const Text("Closed"),
              body: InvAdjOutTable(
                sfDataGridKey: sfDataGridKey,
                docStatus: DocStatus.closed,
              ),
            ),
            Tab(
              icon: const ImageIcon(
                AssetImage('assets/icons/delete_document.png'),
              ),
              text: const Text("Canceled"),
              body: InvAdjOutTable(
                sfDataGridKey: sfDataGridKey,
                docStatus: DocStatus.canceled,
              ),
            ),
          ],
        );
      }),
    );
  }
}
