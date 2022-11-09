import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/router/router.gr.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/models/models.dart';
import '../../../../data/repositories/repos.dart';
import '../../../../utils/fetching_status.dart';
import '../../../../shared/widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'blocs/fetching_bloc/bloc.dart';
import 'components/customers_table.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();
  int currentTabIndex = 0;

  bool isApproved = false;
  bool isActive = true;

  Future<void> _openTextFile(BuildContext cntx) async {
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
      List<CustomerCreateModel> dataObj = data
          .map(
            (e) => CustomerCreateModel(
              code: e[0],
              cardName: e[1],
              location: e[2],
              firstName: e[3],
              middleInitial: e[4],
              lastName: e[5],
              paymentTerm: e[6],
              contactNumber: e[7].toString(),
              email: e[8].toString().isEmpty ? null : e[8].toString(),
              creditLimit: double.tryParse(e[9].toString()),
            ),
          )
          .toList();
      cntx.router.navigate(
        CustomerWrapper(
          children: [
            CustomersBulkInsertRoute(
              datas: dataObj,
              onRefresh: () {
                cntx.read<CustomerFetchingBloc>().add(
                      FetchCustomers(
                        params: {
                          "is_approved": isApproved,
                          "is_active": isActive,
                        },
                      ),
                    );
              },
            ),
          ],
        ),
      );
    } on Exception catch (e) {
      if (mounted) {}
      CustomDialogBox.errorMessage(cntx, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerFetchingBloc(
        customerRepo: context.read<CustomerRepo>(),
        currUserRepo: context.read<CurrentUserRepo>(),
        objectTypeRepo: context.read<ObjectTypeRepo>(),
      )..add(
          FetchCustomers(
            params: {
              "is_approved": isApproved,
              "is_active": isActive,
            },
          ),
        ),
      child: BaseMasterDataScaffold(
        title: "Customers",
        onNewButton: (context) {
          context.router.navigate(
            CustomerWrapper(
              children: [
                CustomerFormRoute(
                  header: "New Customer",
                  onRefresh: sfDataGridKey.currentState!.refresh,
                ),
              ],
            ),
          );
        },
        onRefreshButton: (_) {
          sfDataGridKey.currentState!.refresh();
        },
        onAttachButton: (context) => _openTextFile(context),
        onSearchChanged: (context, value) {
          context.read<CustomerFetchingBloc>().add(
                OfflineSearchCustomerByKeyword(value),
              );
        },
        child: BlocListener<CustomerFetchingBloc, CustomerFetchingState>(
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
          child: Builder(builder: (context) {
            return TabView(
              tabWidthBehavior: TabWidthBehavior.sizeToContent,
              currentIndex: currentTabIndex,
              closeButtonVisibility: CloseButtonVisibilityMode.never,
              onChanged: (index) {
                setState(() {
                  currentTabIndex = index;
                });
                isApproved = index == 0 ? false : true;
                isActive = index == 2 ? false : true;

                context.read<CustomerFetchingBloc>().add(
                      FetchCustomers(
                        params: {
                          "is_approved": isApproved,
                          "is_active": isActive,
                        },
                      ),
                    );
              },
              tabs: [
                Tab(
                  icon: const ImageIcon(
                    AssetImage('assets/icons/done_document.png'),
                  ),
                  text: const Text("For Approval"),
                  body: CustomersTable(
                    sfDataGridKey: sfDataGridKey,
                    onRefresh: () {
                      context.read<CustomerFetchingBloc>().add(
                            FetchCustomers(
                              params: {
                                "is_approved": isApproved,
                                "is_active": isActive,
                              },
                            ),
                          );
                    },
                  ),
                ),
                Tab(
                  icon: const ImageIcon(
                    AssetImage('assets/icons/done_document.png'),
                  ),
                  text: const Text("Active"),
                  body: CustomersTable(
                    sfDataGridKey: sfDataGridKey,
                    onRefresh: () {
                      context.read<CustomerFetchingBloc>().add(
                            FetchCustomers(
                              params: {
                                "is_approved": isApproved,
                                "is_active": isActive,
                              },
                            ),
                          );
                    },
                  ),
                ),
                Tab(
                  icon: const ImageIcon(
                    AssetImage('assets/icons/done_document.png'),
                  ),
                  text: const Text("InActive"),
                  body: CustomersTable(
                    sfDataGridKey: sfDataGridKey,
                    onRefresh: () {
                      context.read<CustomerFetchingBloc>().add(
                            FetchCustomers(
                              params: {
                                "is_approved": isApproved,
                                "is_active": isActive,
                              },
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
