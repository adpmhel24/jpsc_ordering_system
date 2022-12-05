import 'package:auto_route/auto_route.dart';

import 'main_wrapper.dart';
import 'reports_menu.dart';

const reportsMenuRouters = CustomRoute(
  transitionsBuilder: TransitionsBuilders.noTransition,
  durationInMilliseconds: 5,
  page: ReportMainWrapper,
  name: ReportMainWrapper.routeName,
  path: "reports",
  children: [
    CustomRoute(
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        page: ReportsMenuPage,
        path: "menu",
        initial: true),
    // CustomRoute(
    //   transitionsBuilder: TransitionsBuilders.noTransition,
    //   durationInMilliseconds: 5,
    //   page: EmptyRouterPage,
    //   name: 'CustomLastPurchase',
    //   path: "price_quotation/",
    //   children: [
    //     CustomRoute(
    //         transitionsBuilder: TransitionsBuilders.noTransition,
    //         durationInMilliseconds: 5,
    //         page: CustomersLastPurchasePage,
    //         path: "",
    //         initial: true),
    //     CustomRoute(
    //       transitionsBuilder: TransitionsBuilders.noTransition,
    //       durationInMilliseconds: 5,
    //       page: PriceQuotationHeaderDetailsPage,
    //       path: ":id",
    //     ),
    //   ],
    // )
  ],
);
