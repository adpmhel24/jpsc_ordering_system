import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/repositories/repos.dart';
import '../../../../global_bloc/bloc_menu/bloc.dart';
import '../../../../router/router.gr.dart';
import '../../../utils/fetching_status.dart';
import '../../../widgets/custom_animated_dialog.dart';
import 'bloc/bloc.dart';

import 'pq_base_screen.dart';

class PriceQuotationScreen extends StatefulWidget {
  const PriceQuotationScreen({Key? key}) : super(key: key);

  static const childrenRoutes = [
    AutoRoute(
      page: PurchaseQuotationsBaseScreen,
      path: "my_transaction",
    ),
  ];

  @override
  State<PriceQuotationScreen> createState() => _PriceQuotationScreenState();
}

class _PriceQuotationScreenState extends State<PriceQuotationScreen> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();
  DateFormat dateFormat = DateFormat("MM/dd/yyyy");

  @override
  void dispose() {
    _startdateController.dispose();
    _enddateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PriceQuotationsBloc(context.read<PriceQuotationRepo>())
            ..add(
              FetchPriceQuotation(
                fromDate: _startdateController.text,
                toDate: _enddateController.text,
                pqStatus: 0,
                docStatus: "O",
              ),
            ),
      child: BlocListener<PriceQuotationsBloc, PriceQuotationsState>(
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
            PurchaseQuotationsBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              docStatus: "O",
              pqStatus: 0,
            ),
            PurchaseQuotationsBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              pqStatus: 1,
              docStatus: "O",
            ),
            PurchaseQuotationsBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              pqStatus: 2,
              docStatus: "O",
            ),
            PurchaseQuotationsBaseScreenRoute(
              startdateController: _startdateController,
              enddateController: _enddateController,
              pqStatus: 3,
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
                    if (index == 0 || index == 1) {
                      _startdateController.text = "";
                      _enddateController.text = "";
                    } else {
                      _startdateController.text =
                          dateFormat.format(DateTime.now());
                      _enddateController.text =
                          dateFormat.format(DateTime.now());
                    }
                  });
                  switch (index) {
                    case 0:
                      context.read<PriceQuotationsBloc>().add(
                            FetchPriceQuotation(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              pqStatus: 0,
                              docStatus: "O",
                            ),
                          );
                      context.read<DrawerMenuBloc>().add(
                          const DrawerMenuClicked("For Price Confirmation"));
                      break;
                    case 1:
                      context.read<PriceQuotationsBloc>().add(
                            FetchPriceQuotation(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              pqStatus: 1,
                              docStatus: "O",
                            ),
                          );
                      context
                          .read<DrawerMenuBloc>()
                          .add(const DrawerMenuClicked("For SAP SQ"));
                      break;
                    case 2:
                      context.read<PriceQuotationsBloc>().add(
                            FetchPriceQuotation(
                              fromDate: _startdateController.text,
                              toDate: _enddateController.text,
                              pqStatus: 2,
                              docStatus: "O",
                            ),
                          );
                      context
                          .read<DrawerMenuBloc>()
                          .add(const DrawerMenuClicked("With SAP SQ"));
                      break;
                    // case 3:
                    //   context.read<PriceQuotationsBloc>().add(
                    //         FetchPriceQuotation(
                    //           fromDate: _startdateController.text,
                    //           toDate: _enddateController.text,
                    //           pqStatus: 3,
                    //           docStatus: "C",
                    //         ),
                    //       );
                    //   context
                    //       .read<DrawerMenuBloc>()
                    //       .add(const DrawerMenuClicked("Dispatched"));
                    //   break;
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
                    label: 'For SAP SQ',
                    icon: ImageIcon(
                      AssetImage('assets/icons/credit-card.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'With SAP SQ',
                    icon: ImageIcon(
                      AssetImage('assets/icons/done_document.png'),
                    ),
                  ),
                  // BottomNavigationBarItem(
                  //   label: 'Dispatched',
                  //   icon: ImageIcon(
                  //     AssetImage('assets/icons/truck-moving.png'),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
