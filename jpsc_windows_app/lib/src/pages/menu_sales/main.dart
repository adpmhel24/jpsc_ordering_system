import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'modules/sales_order/sales_orders.dart';
import 'modules/sales_order/widgets/details/so_details.dart';
import 'sales_menu.dart';

class SalesMenuWrapperPage extends StatelessWidget {
  const SalesMenuWrapperPage({Key? key}) : super(key: key);

  static const routers = AutoRoute(
    page: SalesMenuWrapperPage,
    path: "sales",
    children: [
      AutoRoute(page: SalesMenuPage, path: "menu", initial: true),
      AutoRoute(
        page: EmptyRouterPage,
        name: 'SalesOrderWrapper',
        path: "sales_order",
        children: [
          AutoRoute(page: SalesOrderPage, path: "", initial: true),
          AutoRoute(page: SalesOrderHeaderDetailsPage, path: ""),
        ],
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return const AutoRouter(
      key: GlobalObjectKey("sales"),
    );
  }
}
