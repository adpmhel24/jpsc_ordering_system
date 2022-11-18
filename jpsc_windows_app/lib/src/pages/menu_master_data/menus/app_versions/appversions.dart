import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:jpsc_windows_app/src/router/router.gr.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repo_app_version.dart';

import '../scaffold_base.dart';
import 'blocs/fetching_versions_bloc/bloc.dart';
import 'components/versions_table.dart';

class AppVersionPage extends StatefulWidget {
  const AppVersionPage({Key? key}) : super(key: key);

  @override
  State<AppVersionPage> createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchingAppVersionsBloc(context.read<AppVersionRepo>())
            ..add(LoadAppVersions()),
      child: BaseMasterDataScaffold(
        title: "App Versions",
        onNewButton: (context) {
          context.router.navigate(
            AppVersionsWrapper(
              children: [
                AppVersionFormRoute(
                  header: "Add New App Version",
                  onRefresh: () => context.read<FetchingAppVersionsBloc>().add(
                        LoadAppVersions(),
                      ),
                ),
              ],
            ),
          );
        },
        onRefreshButton: (context) {
          context.read<FetchingAppVersionsBloc>().add(
                LoadAppVersions(),
              );
        },
        onSearchChanged: (context, value) {},
        child: AppVersionsTable(
          sfDataGridKey: sfDataGridKey,
        ),
      ),
    );
  }
}
