import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:jpsc_windows_app/src/data/models/uom/model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../global_blocs/blocs.dart';
import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../../shared/widgets/custom_dialog.dart';
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
      List<UomModel> uoms = data
          .map((e) => UomModel(code: e[0], description: e[1], isActive: true))
          .toList();
      context.router.navigate(
        UomsWrapper(
          children: [
            UomsToUploadRoute(
              uoms: uoms,
              onRefresh: () {
                context.read<UomsBloc>().add(LoadUoms());
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
    return BlocListener<UomsBloc, UomsBlocState>(
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
      child: BaseMasterDataScaffold(
        title: "Unit Of Measures",
        onNewButton: (context) {
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
        onRefreshButton: (context) {
          context.read<UomsBloc>().add(LoadUoms());
        },
        onAttachButton: (cntx) => _openTextFile(cntx),
        onSearchChanged: (context, value) {},
        child: UomsTable(
          sfDataGridKey: sfDataGridKey,
        ),
      ),
    );
  }
}
