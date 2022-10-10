import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'modules/price_quotation/price_quotation.dart';
import 'modules/price_quotation/components/details/pq_details.dart';
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
        name: 'PriceQuotationWrapper',
        path: "sales_order",
        children: [
          AutoRoute(page: PriceQuotationPage, path: "", initial: true),
          AutoRoute(page: PriceQuotationHeaderDetailsPage, path: ""),
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
