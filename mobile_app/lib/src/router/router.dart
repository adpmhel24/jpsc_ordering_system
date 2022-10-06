import 'package:auto_route/auto_route.dart';

import '../screens/login_screen/login_screen.dart';
import '../screens/modules/Dashboard/dashboard.dart';
import '../screens/modules/Master_Data/customer/create_customer/address_form.dart';
import '../screens/modules/Master_Data/customer/create_customer/create_customer_screen.dart';
import '../screens/modules/Sales_Order/create_sales_order/create_sales_order_screen.dart';
import '../screens/modules/Sales_Order/sales_orders/sales_orders_screen.dart';
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
        AutoRoute(page: DashboardScreen, path: "dashboard"),
        AutoRoute(
            page: CreateSalesOrderScreen,
            path: "create",
            children: CreateSalesOrderScreen.childrenRoutes,
            initial: true),
        AutoRoute(
          page: SalesOrdersScreen,
          path: "sales_orders",
          children: SalesOrdersScreen.childrenRoutes,
        ),
        AutoRoute(page: CreateCustomerScreen, path: 'create_customer'),
      ],
    ),
    AutoRoute(page: AddressFormScreen, path: '/address_form'),
  ],
)
class $AppRouter {}
