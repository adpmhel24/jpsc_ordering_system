import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/customers.dart';

import '../pages/exports.dart';
import '../pages/menu_master_data/menus/customers/components/form/customer_form.dart';
import '../pages/menu_master_data/menus/payment_terms/components/form.dart';
import '../pages/menu_master_data/menus/payment_terms/payment_terms.dart';
import '../pages/menu_sales/main.dart';
import 'router_guard.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, path: '/login'),
    AutoRoute(
      page: MainPage,
      path: '/',
      guards: [RouteGuard],
      initial: true,
      children: [
        AutoRoute(page: DashboardPage, path: "dashboard", initial: true),
        AutoRoute(page: PurchasingMenuPage, path: "purchasing"),
        SalesMenuWrapperPage.routers,
        InventoryWrapperPage.routers,
        AutoRoute(
          page: MasterDataWrapperPage,
          path: "master_data",
          children: [
            AutoRoute(page: MasterDataMenuPage, path: "menu", initial: true),
            AutoRoute(
              page: EmptyRouterPage,
              name: 'SystemUsersWrapper',
              path: "systemUsers",
              children: [
                AutoRoute(page: SystemUsersPage, path: "", initial: true),
                AutoRoute(page: SystemUserCreateFormPage, path: "create"),
                AutoRoute(page: SystemUserUpdateFormPage, path: "edit"),
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: 'CustomerWrapper',
              path: "customer",
              children: [
                AutoRoute(page: CustomersPage, path: "", initial: true),
                AutoRoute(page: CustomerFormPage, path: "create"),
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: 'BranchesWrapper',
              path: "branches",
              children: [
                AutoRoute(page: BranchesPage, path: "", initial: true),
                AutoRoute(
                  page: BranchFormPage,
                  name: "BranchCreateRoute",
                  path: "create",
                ),
                AutoRoute(
                  page: BranchFormPage,
                  name: "BranchEditRoute",
                  path: "edit",
                )
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: "UomsWrapper",
              path: "uoms",
              children: [
                AutoRoute(page: UomsPage, path: "", initial: true),
                AutoRoute(
                  page: UomFormPage,
                  name: "UomCreateRoute",
                  path: "create",
                ),
                AutoRoute(
                  page: UomFormPage,
                  name: "UomEditRoute",
                  path: "edit",
                )
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: "PricelistWrapper",
              path: "pricelist",
              children: [
                AutoRoute(page: PricelistPage, path: "", initial: true),
                AutoRoute(
                  page: PricelistFormPage,
                  name: "PricelistCreateRoute",
                  path: "create",
                ),
                AutoRoute(
                  page: PricelistRowPage,
                  name: "PricelistRowRoute",
                  path: "pricelist_row",
                )
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: "ItemWrapper",
              path: "items",
              children: [
                AutoRoute(page: ItemsPage, path: "", initial: true),
                AutoRoute(
                  page: ItemFormPage,
                  name: "ItemCreatePage",
                  path: "create",
                ),
                AutoRoute(
                  page: ItemFormPage,
                  name: "ItemEditPage",
                  path: "edit",
                )
              ],
            ),
            AutoRoute(
              page: EmptyRouterPage,
              name: "PaymentTermWrapper",
              path: "payment_terms",
              children: [
                AutoRoute(page: PaymentTermsPage, path: "", initial: true),
                AutoRoute(
                  page: PaymentTermFormPage,
                  path: "form",
                ),
                // AutoRoute(
                //   page: ItemFormPage,
                //   name: "ItemEditPage",
                //   path: "edit",
                // )
              ],
            ),
          ],
        ),
      ],
    )
  ],
)
class $AppRouter {}
