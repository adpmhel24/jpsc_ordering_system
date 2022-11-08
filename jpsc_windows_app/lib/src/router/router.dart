import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/customers.dart';
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/products/widgets/upload_page.dart';

import '../pages/exports.dart';
import '../pages/menu_master_data/menus/customers/components/form/customer_form.dart';
import '../pages/menu_master_data/menus/customers/components/upload_page.dart';
import '../pages/menu_master_data/menus/item_group/form/form.dart';
import '../pages/menu_master_data/menus/item_group/item_group.dart';
import '../pages/menu_master_data/menus/item_group/components/upload_page.dart';
import '../pages/menu_master_data/menus/payment_terms/components/form.dart';
import '../pages/menu_master_data/menus/payment_terms/payment_terms.dart';
import '../pages/menu_master_data/menus/system_users/components/upload_page.dart';
import '../pages/menu_master_data/menus/uoms/widgets/uoms_to_upload.dart';
import '../pages/menu_sales/main.dart';
import '../pages/my_profile/my_profile_page.dart';
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
            path: "dashboard",
            initial: true),
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 5,
            page: PurchasingMenuPage,
            path: "purchasing"),
        SalesMenuWrapperPage.routers,
        InventoryWrapperPage.routers,
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 5,
          page: MasterDataWrapperPage,
          path: "master_data",
          children: [
            CustomRoute(
                transitionsBuilder: TransitionsBuilders.noTransition,
                durationInMilliseconds: 5,
                page: MasterDataMenuPage,
                path: "menu",
                initial: true),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: 'SystemUsersWrapper',
              path: "systemUsers",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: SystemUsersPage,
                    path: "",
                    initial: true),
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: SystemUserFormPage,
                    path: "form"),
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: SystemUsersToUploadPage,
                    path: "for_upload"),
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: 'CustomerWrapper',
              path: "customer",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: CustomersPage,
                    path: "",
                    initial: true),
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: CustomerFormPage,
                    path: "create"),
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: CustomersBulkInsertPage,
                    path: "for_upload"),
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: 'BranchesWrapper',
              path: "branches",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: BranchesPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: BranchFormPage,
                  name: "BranchCreateRoute",
                  path: "create",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: BranchFormPage,
                  name: "BranchEditRoute",
                  path: "edit",
                )
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: "UomsWrapper",
              path: "uoms",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: UomsPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: UomFormPage,
                  name: "UomCreateRoute",
                  path: "create",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: UomFormPage,
                  name: "UomEditRoute",
                  path: "edit",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: UomsToUploadPage,
                  path: "for_upload",
                ),
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: "ItemGroupWrapper",
              path: "itemGroup",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: ItemGroupPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: ItemGroupFormPage,
                  path: "form",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: ItemGroupsToUploadPage,
                  path: "for_upload",
                ),
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: "PricelistWrapper",
              path: "pricelist",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: PricelistPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: PricelistFormPage,
                  name: "PricelistFormRoute",
                  path: "create",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: PricelistRowPage,
                  name: "PricelistRowRoute",
                  path: "pricelist_row",
                )
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: "ProductsWrapper",
              path: "products",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: ProductPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: ProductFormPage,
                  path: "form",
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: ProductBulkInsertPage,
                  path: "for_upload",
                ),
              ],
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.noTransition,
              durationInMilliseconds: 5,
              page: EmptyRouterPage,
              name: "PaymentTermWrapper",
              path: "payment_terms",
              children: [
                CustomRoute(
                    transitionsBuilder: TransitionsBuilders.noTransition,
                    durationInMilliseconds: 5,
                    page: PaymentTermsPage,
                    path: "",
                    initial: true),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.noTransition,
                  durationInMilliseconds: 5,
                  page: PaymentTermFormPage,
                  path: "form",
                ),
                // CustomRoute(transitionsBuilder: TransitionsBuilders.noTransition,
                // durationInMilliseconds: 5,
                //   page: ItemFormPage,
                //   name: "ItemEditPage",
                //   path: "edit",
                // )
              ],
            ),
          ],
        ),
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 5,
            page: MyProfilePage,
            path: "my_account")
      ],
    )
  ],
)
class $AppRouter {}
