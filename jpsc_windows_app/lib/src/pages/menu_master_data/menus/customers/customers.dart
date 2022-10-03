import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpsc_windows_app/src/router/router.gr.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_blocs/bloc_customer/fetching_bloc/bloc.dart';
import '../../../../utils/fetching_status.dart';
import '../../../widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'widgets/customers_table.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomerFetchingBloc(context.read<CustomerRepo>())
        ..add(
          FetchCustomers(
            params: {
              "is_approved": isApproved,
              "is_active": isActive,
            },
          ),
        ),
      child: BaseMasterDataScaffold(
        title: "Customers",
        onNewButton: () {
          context.router.navigate(
            CustomerWrapper(
              children: [
                CustomerFormRoute(
                  header: "New Customer",
                ),
              ],
            ),
          );
        },
        onRefreshButton: () {
          sfDataGridKey.currentState!.refresh();
        },
        onSearchChanged: (value) {},
        child: BlocListener<CustomerFetchingBloc, CustomerFetchingState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (_, state) {
            if (state.status == FetchingStatus.loading) {
              context.loaderOverlay.show();
            } else if (state.status == FetchingStatus.success) {
              context.loaderOverlay.hide();
            } else if (state.status == FetchingStatus.error) {
              context.loaderOverlay.hide();
              CustomDialogBox.errorMessage(context, message: state.message);
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
