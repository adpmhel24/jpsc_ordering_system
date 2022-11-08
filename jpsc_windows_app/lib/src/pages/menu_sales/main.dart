import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'modules/price_quotation/price_quotation.dart';
import 'modules/price_quotation/components/details/pq_details.dart';
import 'sales_menu.dart';

class SalesMenuWrapperPage extends StatefulWidget {
  const SalesMenuWrapperPage({Key? key}) : super(key: key);

  static const routers = CustomRoute(
    transitionsBuilder: TransitionsBuilders.noTransition,
    durationInMilliseconds: 5,
    page: SalesMenuWrapperPage,
    path: "sales",
    children: [
      CustomRoute(
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 5,
          page: SalesMenuPage,
          path: "menu",
          initial: true),
      CustomRoute(
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        page: EmptyRouterPage,
        name: 'PriceQuotationWrapper',
        path: "sales_order",
        children: [
          CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: PriceQuotationPage,
              path: "",
              initial: true),
          CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: PriceQuotationHeaderDetailsPage,
              path: ""),
        ],
      )
    ],
  );

  @override
  State<SalesMenuWrapperPage> createState() => _SalesMenuWrapperPageState();
}

class _SalesMenuWrapperPageState extends State<SalesMenuWrapperPage> {
  final _innerRouterKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      key: _innerRouterKey,
    );
  }
}
