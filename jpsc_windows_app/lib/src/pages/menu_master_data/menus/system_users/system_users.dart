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

class SystemUsersPage extends StatefulWidget {
  const SystemUsersPage({Key? key}) : super(key: key);

  @override
  State<SystemUsersPage> createState() => _SystemUsersPageState();
}

class _SystemUsersPageState extends State<SystemUsersPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    context.read<SystemUsersBloc>().add(LoadSystemUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SystemUsersBloc, SystemUsersBlocState>(
      listener: (context, state) {
        if (state.status == FetchingStatus.loading) {
          context.loaderOverlay.show();
        } else if (state.status == FetchingStatus.error) {
          context.loaderOverlay.hide();
          CustomDialogBox.errorMessage(context, message: state.message);
        } else if (state.status == FetchingStatus.success) {
          context.loaderOverlay.hide();
        }
      },
      child: BaseMasterDataScaffold(
        title: "System Users",
        onNewButton: () {
          context.router.navigate(const SystemUsersWrapper(
              children: [SystemUserCreateFormRoute()]));
        },
        onRefreshButton: () {
          sfDataGridKey.currentState!.refresh();
        },
        onSearchChanged: (value) {},
        child: SystemUsersTable(
          sfDataGridKey: sfDataGridKey,
        ),
      ),
    );
  }
}
