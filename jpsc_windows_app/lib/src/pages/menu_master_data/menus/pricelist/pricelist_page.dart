import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'blocs/fetching_pricelists/bloc.dart';
import 'widgets/pricelist_h_table.dart';

class PricelistPage extends StatefulWidget {
  const PricelistPage({Key? key}) : super(key: key);

  @override
  State<PricelistPage> createState() => _PricelistPageState();
}

class _PricelistPageState extends State<PricelistPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PricelistFetchingBloc(
        pricelistRepo: context.read<PricelistRepo>(),
        currUserRepo: context.read<CurrentUserRepo>(),
        objectTypeRepo: context.read<ObjectTypeRepo>(),
      )..add(LoadPricelist()),
      child: BlocListener<PricelistFetchingBloc, PricelistFetchingState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == FetchingStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == FetchingStatus.error) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.errorMessage);
          } else if (state.status == FetchingStatus.success) {
            context.loaderOverlay.hide();
          } else if (state.status == FetchingStatus.unauthorized) {
            context.loaderOverlay.hide();
          }
        },
        child: Builder(builder: (context) {
          return BaseMasterDataScaffold(
            title: "Pricelist",
            onNewButton: () {
              context.router.navigate(
                PricelistWrapper(
                  children: [
                    PricelistFormRoute(
                      header: "Pricelist Create Form",
                      refresh: sfDataGridKey.currentState!.refresh,
                    ),
                  ],
                ),
              );
            },
            onRefreshButton: () {
              context.read<PricelistFetchingBloc>().add(LoadPricelist());
            },
            onSearchChanged: (value) {},
            child: PricelistHeaderTable(
              sfDataGridKey: sfDataGridKey,
            ),
          );
        }),
      ),
    );
  }
}
