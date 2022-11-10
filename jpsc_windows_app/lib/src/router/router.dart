import 'package:auto_route/auto_route.dart';

import '../pages/exports.dart';

import '../pages/menu_master_data/routers.dart';
import '../pages/menu_profile/my_profile_page.dart';
import '../pages/menu_sales/routers.dart';
import '../pages/unknown_page.dart';
import 'router_guard.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        page: LoginPage,
        path: '/login'),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.noTransition,
      durationInMilliseconds: 5,
      page: MainPage,
      path: '/',
      guards: [RouteGuard],
      initial: true,
      children: [
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 5,
            page: DashboardPage,
            name: DashboardPage.routeName,
            path: "dashboard",
            initial: true),
        masterDataMenuRouters,
        salesMenuRouters,
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 5,
          page: MyProfile,
          name: MyProfile.routeName,
          path: "my_account",
        )
      ],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.noTransition,
      durationInMilliseconds: 5,
      path: '*',
      page: UnknownRoutePage,
    ),
  ],
)
class $AppRouter {}
