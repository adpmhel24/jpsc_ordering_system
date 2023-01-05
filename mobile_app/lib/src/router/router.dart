import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../screens/login_screen/login_screen.dart';
import '../screens/modules/Master_Data/customer/create_customer/address_form.dart';
import '../screens/modules/Master_Data/customer/create_customer/create_customer_screen.dart';
import '../screens/modules/My_Profile/my_profile.dart';
import '../screens/modules/Price_Quotation/create_price_quotation/create_pq_screen.dart';
import '../screens/modules/Price_Quotation/price_quotations/purch_quotations_screen.dart';
import '../screens/modules/main_screen.dart';
import '../screens/new_version_screen/new_version_screen.dart';
import '../screens/widgets/success_screen.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, path: '/login'),
    AutoRoute(page: NewVersionScreen, path: '/new_version'),
    AutoRoute(
        page: EmptyRouterPage,
        name: 'NavigationHandlerRoute',
        path: "/",
        children: [
          AutoRoute(
            page: MainScreen,
            path: '',
            initial: true,
            children: [
              // AutoRoute(page: DashboardScreen, path: "dashboard", initial: true),
              AutoRoute(
                page: CreatePriceQuotationScreen,
                path: "create_pq",
                children: CreatePriceQuotationScreen.childrenRoutes,
                initial: true,
              ),
              AutoRoute(
                page: PriceQuotationScreen,
                path: "price_quotations",
                children: PriceQuotationScreen.childrenRoutes,
              ),
              AutoRoute(page: CreateCustomerScreen, path: 'create_customer'),
              AutoRoute(page: MyProfilePage, path: 'my_profile'),
            ],
          ),
          AutoRoute(page: AddressFormScreen, path: 'address_form'),
          AutoRoute(page: SuccessScreen, path: 'success_screen'),
        ]),
  ],
)
class $AppRouter {}
