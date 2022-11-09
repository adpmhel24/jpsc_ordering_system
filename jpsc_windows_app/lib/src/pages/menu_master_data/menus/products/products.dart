import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:jpsc_windows_app/src/data/models/models.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'blocs/fetching_bloc/bloc.dart';
import 'widgets/table.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
      List<CreateProductModel> datas = data
          .map(
            (e) => CreateProductModel(
              code: e[0],
              description: e[1],
              saleUomCode: e[2],
              itemGroupCode: e[3],
            ),
          )
          .toList();
      context.router.navigate(
        ProductsWrapper(
          children: [
            ProductBulkInsertRoute(
                datas: datas,
                onRefresh: () {
                  context
                      .read<FetchingProductsBloc>()
                      .add(LoadProductsOnline());
                }),
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
      create: (context) => FetchingProductsBloc(
        productRepo: context.read<ProductRepo>(),
        currUserRepo: context.read<CurrentUserRepo>(),
        objectTypeRepo: context.read<ObjectTypeRepo>(),
      )..add(LoadProductsOnline()),
      child: Builder(builder: (context) {
        return BlocListener<FetchingProductsBloc, FetchingProductsState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == FetchingStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == FetchingStatus.error) {
              context.loaderOverlay.hide();
              CustomDialogBox.errorMessage(context,
                  message: state.errorMessage);
            } else if (state.status == FetchingStatus.success) {
              context.loaderOverlay.hide();
            } else if (state.status == FetchingStatus.unauthorized) {
              context.loaderOverlay.hide();
            }
          },
          child: BaseMasterDataScaffold(
            title: "Products",
            onNewButton: (context) {
              context.router.navigate(
                ProductsWrapper(
                  children: [
                    ProductFormRoute(
                      header: "Product Form",
                      onRefresh: () => context
                          .read<FetchingProductsBloc>()
                          .add(LoadProductsOnline()),
                    ),
                  ],
                ),
              );
            },
            onAttachButton: (context) {
              _openTextFile(context);
            },
            onRefreshButton: (context) {
              context.read<FetchingProductsBloc>().add(LoadProductsOnline());
            },
            onSearchChanged: (context, value) {
              context
                  .read<FetchingProductsBloc>()
                  .add(OfflineProductSearchByKeyword(value));
            },
            child: ItemsTable(
              sfDataGridKey: sfDataGridKey,
            ),
          ),
        );
      }),
    );
  }
}
