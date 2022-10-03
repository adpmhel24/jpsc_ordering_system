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

class UomsPage extends StatefulWidget {
  const UomsPage({Key? key}) : super(key: key);

  @override
  State<UomsPage> createState() => _UomsPageState();
}

class _UomsPageState extends State<UomsPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    context.read<UomsBloc>().add(LoadUoms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UomsBloc, UomsBlocState>(
      listener: (context, state) {
        if (state.status == FetchingStatus.loading) {
          context.loaderOverlay.show();
        } else if (state.status == FetchingStatus.error) {
          context.loaderOverlay.hide();
          CustomDialogBox.errorMessage(context, message: state.errorMessage);
        } else if (state.status == FetchingStatus.success) {
          context.loaderOverlay.hide();
        }
      },
      child: BaseMasterDataScaffold(
        title: "Unit Of Measures",
        onNewButton: () {
          context.router.navigate(
            UomsWrapper(
              children: [
                UomCreateRoute(
                  header: "UoM Create Form",
                ),
              ],
            ),
          );
        },
        onRefreshButton: () {
          sfDataGridKey.currentState!.refresh();
        },
        onSearchChanged: (value) {},
        child: UomsTable(
          sfDataGridKey: sfDataGridKey,
        ),
      ),
    );
  }
}
