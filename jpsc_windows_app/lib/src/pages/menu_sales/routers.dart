import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import 'main_wrapper.dart';
import 'modules/price_quotation/components/details/pq_details.dart';
import 'modules/price_quotation/price_quotation.dart';
import 'sales_menu.dart';

const salesMenuRouters = CustomRoute(
  transitionsBuilder: TransitionsBuilders.noTransition,
  durationInMilliseconds: 5,
  page: SalesMainWrapper,
  name: SalesMainWrapper.routeName,
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
      path: "price_quotation",
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
