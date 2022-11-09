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
import 'blocs/fetching_bloc/bloc.dart';
import 'components/table.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingBranchesBloc(
        branchRepo: context.read<BranchRepo>(),
        currUserRepo: context.read<CurrentUserRepo>(),
        objectTypeRepo: context.read<ObjectTypeRepo>(),
      )..add(LoadBranches()),
      child: BlocListener<FetchingBranchesBloc, FetchingBranchesState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == FetchingStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == FetchingStatus.error) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status == FetchingStatus.success) {
            context.loaderOverlay.hide();
          } else if (state.status == FetchingStatus.unauthorized) {
            context.loaderOverlay.hide();
          }
        },
        child: BaseMasterDataScaffold(
          title: "Branches",
          onNewButton: (context) {
            context.router.navigate(
              BranchesWrapper(
                children: [
                  BranchCreateRoute(
                    header: "Branch Create Form",
                    onRefresh: () => context.read<FetchingBranchesBloc>().add(
                          LoadBranches(),
                        ),
                  ),
                ],
              ),
            );
          },
          onRefreshButton: (context) {
            context.read<FetchingBranchesBloc>().add(LoadBranches());
          },
          onSearchChanged: (context, value) {
            context
                .read<FetchingBranchesBloc>()
                .add(SearchBranchesByKeyword(value));
          },
          child: BranchesTable(
            sfDataGridKey: sfDataGridKey,
          ),
        ),
      ),
    );
  }
}
