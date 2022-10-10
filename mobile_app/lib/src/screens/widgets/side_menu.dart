import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/src/router/router.gr.dart';

import '../../data/repositories/repos.dart';
import '../../global_bloc/bloc_auth/bloc.dart';
import '../../global_bloc/bloc_menu/bloc.dart';
import '../utils/constant.dart';
import '../utils/responsive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  void toggleMenu(BuildContext context) {
    RepositoryProvider.of<MenuController>(context).controlMenu();
  }

  @override
  Widget build(BuildContext context) {
    final router = context.innerRouterOf<StackRouter>(MainScreenRoute.name);
    bool isDesktop = Responsive.isDesktop(context);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/images/logo.png"),
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashbord.svg",
                  press: () {
                    if (!isDesktop) {
                      toggleMenu(context);
                    }
                    router!.replace(const DashboardScreenRoute());
                    context.read<DrawerMenuBloc>().add(
                          const DrawerMenuClicked("Dashboard"),
                        );
                  },
                ),
                DrawerListTile(
                  title: "Create Price Quotation",
                  svgSrc: "assets/icons/menu_tag.svg",
                  press: () {
                    if (!isDesktop) {
                      toggleMenu(context);
                    }
                    router!.replace(const CreatePriceQuotationScreenRoute());
                    context.read<DrawerMenuBloc>().add(
                          const DrawerMenuClicked("Create Price Quotation"),
                        );
                  },
                ),
                DrawerListTile(
                  title: "My Transactions",
                  svgSrc: "assets/icons/shopping-cart-check.svg",
                  press: () {
                    if (!isDesktop) {
                      toggleMenu(context);
                    }
                    router!.replace(const PriceQuotationScreenRoute());
                    context.read<DrawerMenuBloc>().add(
                          const DrawerMenuClicked("For Price Confirmation"),
                        );
                  },
                ),
                DrawerListTile(
                  title: "Create Customer",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {
                    if (!isDesktop) {
                      toggleMenu(context);
                    }
                    router!.replace(const CreateCustomerScreenRoute());
                    context.read<DrawerMenuBloc>().add(
                          const DrawerMenuClicked("Create Customer"),
                        );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                DrawerListTile(
                  title: "Logout",
                  svgSrc: "assets/icons/sign_out.svg",
                  press: () {
                    context.read<AuthBloc>().add(LogoutSubmitted());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DrawerExpansionListTile _buildSalesMenu(
  //   BuildContext context,
  //   bool isDesktop,
  //   StackRouter? router,
  // ) {
  //   return DrawerExpansionListTile(
  //     title: "Price Quotation",
  //     svgSrc: "assets/icons/menu_tag.svg",
  //     children: [
  //       DrawerListTile(
  //         title: "Create Price Quotation",
  //         press: () {
  //           if (!isDesktop) {
  //             toggleMenu(context);
  //           }
  //           router!.replace(
  //               const SalesOrder(children: [CreatePriceQuotationScreenRoute()]));
  //         },
  //       ),
  //       DrawerListTile(
  //         title: "Price Quotations",
  //         press: () {
  //           if (!isDesktop) {
  //             toggleMenu(context);
  //           }

  //           router!.replace(
  //               const SalesOrder(children: [PriceQuotationScreenRoute()]));
  //         },
  //       ),
  //     ],
  //   );
  // }

  // DrawerExpansionListTile _buildInventoryMenu() {
  //   // Inventory Transaction Menu
  //   return DrawerExpansionListTile(
  //     title: "Inventory Transaction",
  //     svgSrc: "assets/icons/menu_inventory.svg",
  //     children: [
  //       DrawerListTile(
  //         title: "Inventory Transfer",
  //         press: () {},
  //       ),
  //       DrawerListTile(
  //         title: "Inventory Receipt",
  //         press: () {},
  //       ),
  //       DrawerListTile(
  //         title: "Adjustment In",
  //         press: () {},
  //       ),
  //       DrawerListTile(
  //         title: "Adjustment Out",
  //         press: () {},
  //       ),
  //     ],
  //   );
  // }

  // DrawerExpansionListTile _buildSetupMenu(BuildContext ctx) {
  //   //  Setup Menu
  //   return DrawerExpansionListTile(
  //     title: "Setup",
  //     svgSrc: "assets/icons/menu_setting.svg",
  //     children: [
  //       DrawerListTile(
  //         title: "System User",
  //         press: () {
  //           // if (!Responsive.isDesktop(ctx)) {
  //           //   RepositoryProvider.of<MenuController>(ctx).controlMenu();
  //           // }
  //           // final router = ctx.innerRouterOf<StackRouter>(MainRoute.name);
  //           // router!.popAndPush(
  //           //     const SetupScreenWrapper(children: [SystemUsersRoute()]));
  //         },
  //       ),
  //       DrawerListTile(
  //         title: "Branch",
  //         press: () {
  //           // if (!Responsive.isDesktop(ctx)) {
  //           //   RepositoryProvider.of<MenuController>(ctx).controlMenu();
  //           // }
  //           // final router = ctx.innerRouterOf<StackRouter>(MainRoute.name);
  //           // router!.popAndPush(const SetupScreenWrapper(
  //           //   children: [
  //           //     BranchesRoute(),
  //           //   ],
  //           // ));
  //         },
  //       ),
  //       DrawerListTile(
  //         title: "Warehouse",
  //         press: () {
  //           // if (!Responsive.isDesktop(ctx)) {
  //           //   RepositoryProvider.of<MenuController>(ctx).controlMenu();
  //           // }
  //           // final router = ctx.innerRouterOf<StackRouter>(MainRoute.name);
  //           // router!.popAndPush(
  //           //   const SetupScreenWrapper(
  //           //     children: [
  //           //       WarehousesRoute(),
  //           //     ],
  //           //   ),
  //           // );
  //         },
  //       ),
  //       DrawerListTile(
  //         title: "Item",
  //         press: () {},
  //       ),
  //       DrawerListTile(
  //         title: "Item Group",
  //         press: () {},
  //       ),
  //       DrawerListTile(
  //         title: "Unit Of Measure",
  //         press: () {
  //           // final router = ctx.innerRouterOf<StackRouter>(MainRoute.name);
  //           // router!.popAndPush(
  //           //   const SetupScreenWrapper(
  //           //     children: [
  //           //       UomsRoute(),
  //           //     ],
  //           //   ),
  //           // );
  //         },
  //       ),
  //       DrawerListTile(
  //         title: "UoM Group",
  //         press: () {},
  //       ),
  //     ],
  //   );
  // }

}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title;
  final String? svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: (svgSrc != null)
          ? SvgPicture.asset(
              svgSrc!,
              height: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColorLight
                  : Constant.menuTextColor,
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

class DrawerExpansionListTile extends StatelessWidget {
  const DrawerExpansionListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.children,
  }) : super(key: key);

  final String title, svgSrc;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: SvgPicture.asset(
        svgSrc,
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).primaryColorLight
            : Constant.menuTextColor,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      children: children,
    );
  }
}
