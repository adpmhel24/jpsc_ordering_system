import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/models/models.dart';
import '../../../../data/repositories/repos.dart';
import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'blocs/fetching_bloc/bloc.dart';
import 'components/table.dart';

class SystemUsersPage extends StatefulWidget {
  const SystemUsersPage({Key? key}) : super(key: key);

  @override
  State<SystemUsersPage> createState() => _SystemUsersPageState();
}

class _SystemUsersPageState extends State<SystemUsersPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  Future<void> _openTextFile(BuildContext context) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'csv',
      extensions: <String>['csv'],
    );
    // This demonstrates using an initial directory for the prompt, which should
    // only be done in cases where the application can likely predict where the
    // file would be. In most cases, this parameter should not be provided.
    final String initialDirectory =
        (await getApplicationDocumentsDirectory()).path;
    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[typeGroup],
      initialDirectory: initialDirectory,
    );
    if (file == null) {
      // Operation was canceled by the user.
      return;
    }
    final String filePath = file.path;

    final csvFile = File(filePath).openRead();
    var data = await csvFile
        .transform(utf8.decoder)
        .transform(
          const CsvToListConverter(),
        )
        .toList();
    try {
      List<CreateSystemUserModel> dataObjs = data
          .map(
            (e) => CreateSystemUserModel(
              email: e[0],
              firstName: e[1],
              lastName: e[2],
              positionCode: e[3],
              password: e[4],
              isActive: true,
              isSuperAdmin: false,
            ),
          )
          .toList();
      context.router.navigate(
        SystemUsersWrapper(
          children: [
            SystemUsersToUploadRoute(
              datas: dataObjs,
              onRefresh: () {
                context.read<FetchingSystemUsersBloc>().add(LoadSystemUsers());
              },
            ),
          ],
        ),
      );
    } on Exception catch (e) {
      if (mounted) {
        await CustomDialogBox.errorMessage(context, message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchingSystemUsersBloc(
        systemUserRepo: context.read<SystemUserRepo>(),
        currUserRepo: context.read<CurrentUserRepo>(),
        objectTypeRepo: context.read<ObjectTypeRepo>(),
      )..add(LoadSystemUsers()),
      child: BlocListener<FetchingSystemUsersBloc, FetchingSystemUsersState>(
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
          title: "System Users",
          onNewButton: (context) {
            context.router.navigate(
              SystemUsersWrapper(children: [
                SystemUserFormRoute(
                  onRefresh: () {
                    context
                        .read<FetchingSystemUsersBloc>()
                        .add(LoadSystemUsers());
                  },
                )
              ]),
            );
          },
          onRefreshButton: (context) {
            context.read<FetchingSystemUsersBloc>().add(LoadSystemUsers());
          },
          onAttachButton: ((context) => _openTextFile(context)),
          onSearchChanged: (context, value) {
            context
                .read<FetchingSystemUsersBloc>()
                .add(SearchSystemUserByKeyword(value));
          },
          child: SystemUsersTable(
            sfDataGridKey: sfDataGridKey,
          ),
        ),
      ),
    );
  }
}
