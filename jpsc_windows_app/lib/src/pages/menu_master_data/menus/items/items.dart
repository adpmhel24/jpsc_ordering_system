import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../global_blocs/blocs.dart';
import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'widgets/table.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    context.read<ItemsBloc>().add(LoadItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsBloc, ItemsBlocState>(
      listenWhen: (prev, curr) => prev.status != prev.status,
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
      child: BaseMasterDataScaffold(
        title: "Items",
        onNewButton: () {
          context.router.navigate(
            ItemWrapper(
              children: [
                ItemCreatePage(
                  header: "Item Create Form",
                ),
              ],
            ),
          );
        },
        onRefreshButton: () {
          context.read<ItemsBloc>().add(LoadItems());
        },
        onSearchChanged: (value) {},
        child: ItemsTable(
          sfDataGridKey: sfDataGridKey,
        ),
      ),
    );
  }
}
