import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../router/router.gr.dart';
import '../../../utils/fetching_status.dart';
import '../../../widgets/custom_animated_dialog.dart';
import 'bloc/bloc.dart';

import 'so_base_screent.dart';

class SalesOrdersScreen extends StatefulWidget {
  const SalesOrdersScreen({Key? key}) : super(key: key);

  static const childrenRoutes = [
    AutoRoute(
      page: SalesOrdersBaseScreen,
      path: "orders",
    ),
  ];

  @override
  State<SalesOrdersScreen> createState() => _SalesOrdersScreenState();
}

class _SalesOrdersScreenState extends State<SalesOrdersScreen> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();

  @override
  void dispose() {
    _startdateController.dispose();
    _enddateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesOrdersBloc(context.read<SalesOrderRepo>())
        ..add(
          FetchSalesOrder(
            fromDate: _startdateController.text,
            toDate: _enddateController.text,
            orderStatus: 0,
            docStatus: "O",
          ),
        ),
      child: BlocListener<SalesOrdersBloc, SalesOrdersState>(
        listener: (context, state) {
          if (state.status == FetchingStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == FetchingStatus.error) {
            CustomAnimatedDialog.error(context, message: state.message);
          } else if (state.status == FetchingStatus.success) {
            context.loaderOverlay.hide();
          }
        },
        child: AutoTabsRouter(
          routes: [
            SalesOrdersBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              orderstatus: 0,
              docStatus: "O",
            ),
            SalesOrdersBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              orderstatus: 1,
              docStatus: "O",
            ),
            SalesOrdersBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              orderstatus: 2,
              docStatus: "O",
            ),
            SalesOrdersBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              orderstatus: 3,
              docStatus: "C",
            ),
          ],
          builder: (context, child, animation) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: FadeTransition(
                opacity: animation,
                child: child,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 10,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                  setState(() {
                    _startdateController.text = "";
                    _enddateController.text = "";
                  });
                  switch (index) {
                    case 0:
                      context.read<SalesOrdersBloc>().add(
                            FetchSalesOrder(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              orderStatus: 0,
                              docStatus: "O",
                            ),
                          );
                      break;
                    case 1:
                      context.read<SalesOrdersBloc>().add(
                            FetchSalesOrder(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              orderStatus: 1,
                              docStatus: "O",
                            ),
                          );
                      break;
                    case 2:
                      context.read<SalesOrdersBloc>().add(
                            FetchSalesOrder(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              orderStatus: 2,
                              docStatus: "O",
                            ),
                          );
                      break;
                    case 3:
                      context.read<SalesOrdersBloc>().add(
                            FetchSalesOrder(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              orderStatus: 3,
                              docStatus: "C",
                            ),
                          );
                      break;
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    label: 'For Price Confirmation',
                    icon: ImageIcon(
                      AssetImage('assets/icons/list.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'For Credit Confirmation',
                    icon: ImageIcon(
                      AssetImage('assets/icons/credit-card.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'For Dispatched',
                    icon: ImageIcon(
                      AssetImage('assets/icons/truck-moving.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Dispatched',
                    icon: ImageIcon(
                      AssetImage('assets/icons/truck-moving.png'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
