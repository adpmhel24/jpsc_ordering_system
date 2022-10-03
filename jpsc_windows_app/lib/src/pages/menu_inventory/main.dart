import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'inventory_menu.dart';
import 'menus/inv_adj_in/exports.dart';
import 'menus/inv_adj_out/exports.dart';

class InventoryWrapperPage extends StatelessWidget {
  const InventoryWrapperPage({Key? key}) : super(key: key);

  static const routers = AutoRoute(
    page: InventoryWrapperPage,
    path: "inventory",
    children: [
      AutoRoute(page: InventoryMenuPage, path: "menu", initial: true),
      AutoRoute(
        page: EmptyRouterPage,
        name: 'InvAdjInWrapper',
        path: "inv_adj_in",
        children: [
          AutoRoute(page: InvAdjustmentInPage, path: "", initial: true),
          AutoRoute(
            page: InvAdjustmentInFormPage,
            name: "InvAdjustmentInCreateRoute",
            path: "create",
          ),
          AutoRoute(
            page: InvAdjustmentInDetailsPage,
            name: "InvAdjustmentInDetailsRoute",
            path: "details/:id",
          ),
        ],
      ),
      AutoRoute(
        page: EmptyRouterPage,
        name: 'InvAdjOutWrapper',
        path: "inv_adj_out",
        children: [
          AutoRoute(page: InvAdjustmentOutPage, path: "", initial: true),
          AutoRoute(
            page: InvAdjustmentOutFormPage,
            name: "InvAdjustmentOutCreateRoute",
            path: "create",
          ),
          AutoRoute(
            page: InvAdjustmentOutDetailsPage,
            name: "InvAdjustmentOutDetailsRoute",
            path: "details/:id",
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return const AutoRouter(
      key: GlobalObjectKey("inventory"),
    );
  }
}
