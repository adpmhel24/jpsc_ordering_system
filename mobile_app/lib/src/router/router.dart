import 'package:auto_route/auto_route.dart';

import '../screens/login_screen/login_screen.dart';
import '../screens/modules/Dashboard/dashboard.dart';
import '../screens/modules/Master_Data/customer/create_customer/address_form.dart';
import '../screens/modules/Master_Data/customer/create_customer/create_customer_screen.dart';
import '../screens/modules/Price_Quotation/create_price_quotation/create_pq_screen.dart';
import '../screens/modules/Price_Quotation/price_quotations/purch_quotations_screen.dart';
import '../screens/modules/main_screen.dart';
import '../screens/widgets/success_screen.dart';
import 'router_guard.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, path: '/login'),
    AutoRoute(page: SuccessScreen, path: '/success_screen'),
    AutoRoute(
      page: MainScreen,
      path: '/',
      guards: [RouteGuard],
      children: [
        AutoRoute(page: DashboardScreen, path: "dashboard", initial: true),
        AutoRoute(
          page: CreatePriceQuotationScreen,
          path: "create_pq",
          children: CreatePriceQuotationScreen.childrenRoutes,
        ),
        AutoRoute(
          page: PriceQuotationScreen,
          path: "price_quotations",
          children: PriceQuotationScreen.childrenRoutes,
        ),
        AutoRoute(page: CreateCustomerScreen, path: 'create_customer'),
      ],
    ),
    AutoRoute(page: AddressFormScreen, path: '/address_form'),
  ],
)
class $AppRouter {}
