// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i16;

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:fluent_ui/fluent_ui.dart' as _i12;
import 'package:flutter/material.dart' as _i10;

import '../data/models/models.dart' as _i13;
import '../pages/exports.dart' as _i1;
import '../pages/menu_inventory/menus/inv_adj_in/bloc/inv_adj_in_bloc.dart'
    as _i14;
import '../pages/menu_inventory/menus/inv_adj_out/bloc/inv_adj_out_bloc.dart'
    as _i15;
import '../pages/menu_master_data/menus/customers/customers.dart' as _i7;
import '../pages/menu_master_data/menus/customers/widgets/form/customer_form.dart'
    as _i8;
import '../pages/menu_sales/main.dart' as _i2;
import '../pages/menu_sales/modules/sales_order/sales_orders.dart' as _i5;
import '../pages/menu_sales/modules/sales_order/widgets/details/so_details.dart'
    as _i6;
import '../pages/menu_sales/sales_menu.dart' as _i3;
import 'router_guard.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter({
    _i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
    required this.routeGuard,
  }) : super(navigatorKey);

  final _i11.RouteGuard routeGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PurchasingMenuRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PurchasingMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuWrapperRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.SalesMenuWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryWrapperRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MasterDataWrapperRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.SalesMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesOrderWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesOrderRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.SalesOrderPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesOrderHeaderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<SalesOrderHeaderDetailsRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.SalesOrderHeaderDetailsPage(
          key: args.key,
          header: args.header,
          salesOrder: args.salesOrder,
          onRefresh: args.onRefresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryMenuRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjInWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjOutWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentInRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentInPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentInCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentInCreateRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentInFormPage(
          key: args.key,
          header: args.header,
          invAdjInbloc: args.invAdjInbloc,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentInDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentInDetailsRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentInDetailsPage(
          key: args.key,
          header: args.header,
          id: args.id,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentOutRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentOutPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentOutCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentOutCreateRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentOutFormPage(
          key: args.key,
          header: args.header,
          invAdjOutbloc: args.invAdjOutbloc,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentOutDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentOutDetailsRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentOutDetailsPage(
          key: args.key,
          header: args.header,
          id: args.id,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MasterDataMenuRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemWrapper.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUsersPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserCreateFormRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUserCreateFormPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserUpdateFormRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUserUpdateFormRouteArgs>(
          orElse: () => const SystemUserUpdateFormRouteArgs());
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.SystemUserUpdateFormPage(
          key: args.key,
          selectedSystemUser: args.selectedSystemUser,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.CustomersPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerFormRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.CustomerFormPage(
          key: args.key,
          header: args.header,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BranchesPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BranchCreateRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchEditRoute.name: (routeData) {
      final args = routeData.argsAs<BranchEditRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UomsPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomCreateRoute.name: (routeData) {
      final args = routeData.argsAs<UomCreateRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomEditRoute.name: (routeData) {
      final args = routeData.argsAs<UomEditRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PricelistPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistCreateRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistCreateRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistFormPage(
          key: args.key,
          header: args.header,
          selectedPricelist: args.selectedPricelist,
          refresh: args.refresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRowRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistRowRouteArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistRowPage(
          key: args.key,
          pricelistModel: args.pricelistModel,
          refresh: args.refresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemsRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ItemsPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemCreatePage.name: (routeData) {
      final args = routeData.argsAs<ItemCreatePageArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ItemFormPage(
          key: args.key,
          header: args.header,
          selectedItem: args.selectedItem,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemEditPage.name: (routeData) {
      final args = routeData.argsAs<ItemEditPageArgs>();
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ItemFormPage(
          key: args.key,
          header: args.header,
          selectedItem: args.selectedItem,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i9.RouteConfig(
          MainRoute.name,
          path: '/',
          guards: [routeGuard],
          children: [
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i9.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i9.RouteConfig(
              PurchasingMenuRoute.name,
              path: 'purchasing',
              parent: MainRoute.name,
            ),
            _i9.RouteConfig(
              SalesMenuWrapperRoute.name,
              path: 'sales',
              parent: MainRoute.name,
              children: [
                _i9.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: SalesMenuWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i9.RouteConfig(
                  SalesMenuRoute.name,
                  path: 'menu',
                  parent: SalesMenuWrapperRoute.name,
                ),
                _i9.RouteConfig(
                  SalesOrderWrapper.name,
                  path: 'sales_order',
                  parent: SalesMenuWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      SalesOrderRoute.name,
                      path: '',
                      parent: SalesOrderWrapper.name,
                    ),
                    _i9.RouteConfig(
                      SalesOrderHeaderDetailsRoute.name,
                      path: '',
                      parent: SalesOrderWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i9.RouteConfig(
              InventoryWrapperRoute.name,
              path: 'inventory',
              parent: MainRoute.name,
              children: [
                _i9.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: InventoryWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i9.RouteConfig(
                  InventoryMenuRoute.name,
                  path: 'menu',
                  parent: InventoryWrapperRoute.name,
                ),
                _i9.RouteConfig(
                  InvAdjInWrapper.name,
                  path: 'inv_adj_in',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      InvAdjustmentInRoute.name,
                      path: '',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i9.RouteConfig(
                      InvAdjustmentInCreateRoute.name,
                      path: 'create',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i9.RouteConfig(
                      InvAdjustmentInDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjInWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  InvAdjOutWrapper.name,
                  path: 'inv_adj_out',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      InvAdjustmentOutRoute.name,
                      path: '',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i9.RouteConfig(
                      InvAdjustmentOutCreateRoute.name,
                      path: 'create',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i9.RouteConfig(
                      InvAdjustmentOutDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjOutWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i9.RouteConfig(
              MasterDataWrapperRoute.name,
              path: 'master_data',
              parent: MainRoute.name,
              children: [
                _i9.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MasterDataWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i9.RouteConfig(
                  MasterDataMenuRoute.name,
                  path: 'menu',
                  parent: MasterDataWrapperRoute.name,
                ),
                _i9.RouteConfig(
                  SystemUsersWrapper.name,
                  path: 'systemUsers',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      SystemUsersRoute.name,
                      path: '',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i9.RouteConfig(
                      SystemUserCreateFormRoute.name,
                      path: 'create',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i9.RouteConfig(
                      SystemUserUpdateFormRoute.name,
                      path: 'edit',
                      parent: SystemUsersWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  CustomerWrapper.name,
                  path: 'customer',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      CustomersRoute.name,
                      path: '',
                      parent: CustomerWrapper.name,
                    ),
                    _i9.RouteConfig(
                      CustomerFormRoute.name,
                      path: 'create',
                      parent: CustomerWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  BranchesWrapper.name,
                  path: 'branches',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      BranchesRoute.name,
                      path: '',
                      parent: BranchesWrapper.name,
                    ),
                    _i9.RouteConfig(
                      BranchCreateRoute.name,
                      path: 'create',
                      parent: BranchesWrapper.name,
                    ),
                    _i9.RouteConfig(
                      BranchEditRoute.name,
                      path: 'edit',
                      parent: BranchesWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  UomsWrapper.name,
                  path: 'uoms',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      UomsRoute.name,
                      path: '',
                      parent: UomsWrapper.name,
                    ),
                    _i9.RouteConfig(
                      UomCreateRoute.name,
                      path: 'create',
                      parent: UomsWrapper.name,
                    ),
                    _i9.RouteConfig(
                      UomEditRoute.name,
                      path: 'edit',
                      parent: UomsWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  PricelistWrapper.name,
                  path: 'pricelist',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      PricelistRoute.name,
                      path: '',
                      parent: PricelistWrapper.name,
                    ),
                    _i9.RouteConfig(
                      PricelistCreateRoute.name,
                      path: 'create',
                      parent: PricelistWrapper.name,
                    ),
                    _i9.RouteConfig(
                      PricelistRowRoute.name,
                      path: 'pricelist_row',
                      parent: PricelistWrapper.name,
                    ),
                  ],
                ),
                _i9.RouteConfig(
                  ItemWrapper.name,
                  path: 'items',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i9.RouteConfig(
                      ItemsRoute.name,
                      path: '',
                      parent: ItemWrapper.name,
                    ),
                    _i9.RouteConfig(
                      ItemCreatePage.name,
                      path: 'create',
                      parent: ItemWrapper.name,
                    ),
                    _i9.RouteConfig(
                      ItemEditPage.name,
                      path: 'edit',
                      parent: ItemWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i9.PageRouteInfo<void> {
  const MainRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.PurchasingMenuPage]
class PurchasingMenuRoute extends _i9.PageRouteInfo<void> {
  const PurchasingMenuRoute()
      : super(
          PurchasingMenuRoute.name,
          path: 'purchasing',
        );

  static const String name = 'PurchasingMenuRoute';
}

/// generated route for
/// [_i2.SalesMenuWrapperPage]
class SalesMenuWrapperRoute extends _i9.PageRouteInfo<void> {
  const SalesMenuWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SalesMenuWrapperRoute.name,
          path: 'sales',
          initialChildren: children,
        );

  static const String name = 'SalesMenuWrapperRoute';
}

/// generated route for
/// [_i1.InventoryWrapperPage]
class InventoryWrapperRoute extends _i9.PageRouteInfo<void> {
  const InventoryWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          InventoryWrapperRoute.name,
          path: 'inventory',
          initialChildren: children,
        );

  static const String name = 'InventoryWrapperRoute';
}

/// generated route for
/// [_i1.MasterDataWrapperPage]
class MasterDataWrapperRoute extends _i9.PageRouteInfo<void> {
  const MasterDataWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MasterDataWrapperRoute.name,
          path: 'master_data',
          initialChildren: children,
        );

  static const String name = 'MasterDataWrapperRoute';
}

/// generated route for
/// [_i3.SalesMenuPage]
class SalesMenuRoute extends _i9.PageRouteInfo<void> {
  const SalesMenuRoute()
      : super(
          SalesMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'SalesMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SalesOrderWrapper extends _i9.PageRouteInfo<void> {
  const SalesOrderWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          SalesOrderWrapper.name,
          path: 'sales_order',
          initialChildren: children,
        );

  static const String name = 'SalesOrderWrapper';
}

/// generated route for
/// [_i5.SalesOrderPage]
class SalesOrderRoute extends _i9.PageRouteInfo<void> {
  const SalesOrderRoute()
      : super(
          SalesOrderRoute.name,
          path: '',
        );

  static const String name = 'SalesOrderRoute';
}

/// generated route for
/// [_i6.SalesOrderHeaderDetailsPage]
class SalesOrderHeaderDetailsRoute
    extends _i9.PageRouteInfo<SalesOrderHeaderDetailsRouteArgs> {
  SalesOrderHeaderDetailsRoute({
    _i12.Key? key,
    required String header,
    required _i13.SalesOrderModel salesOrder,
    required void Function() onRefresh,
  }) : super(
          SalesOrderHeaderDetailsRoute.name,
          path: '',
          args: SalesOrderHeaderDetailsRouteArgs(
            key: key,
            header: header,
            salesOrder: salesOrder,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'SalesOrderHeaderDetailsRoute';
}

class SalesOrderHeaderDetailsRouteArgs {
  const SalesOrderHeaderDetailsRouteArgs({
    this.key,
    required this.header,
    required this.salesOrder,
    required this.onRefresh,
  });

  final _i12.Key? key;

  final String header;

  final _i13.SalesOrderModel salesOrder;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'SalesOrderHeaderDetailsRouteArgs{key: $key, header: $header, salesOrder: $salesOrder, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.InventoryMenuPage]
class InventoryMenuRoute extends _i9.PageRouteInfo<void> {
  const InventoryMenuRoute()
      : super(
          InventoryMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'InventoryMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class InvAdjInWrapper extends _i9.PageRouteInfo<void> {
  const InvAdjInWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          InvAdjInWrapper.name,
          path: 'inv_adj_in',
          initialChildren: children,
        );

  static const String name = 'InvAdjInWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class InvAdjOutWrapper extends _i9.PageRouteInfo<void> {
  const InvAdjOutWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          InvAdjOutWrapper.name,
          path: 'inv_adj_out',
          initialChildren: children,
        );

  static const String name = 'InvAdjOutWrapper';
}

/// generated route for
/// [_i1.InvAdjustmentInPage]
class InvAdjustmentInRoute extends _i9.PageRouteInfo<void> {
  const InvAdjustmentInRoute()
      : super(
          InvAdjustmentInRoute.name,
          path: '',
        );

  static const String name = 'InvAdjustmentInRoute';
}

/// generated route for
/// [_i1.InvAdjustmentInFormPage]
class InvAdjustmentInCreateRoute
    extends _i9.PageRouteInfo<InvAdjustmentInCreateRouteArgs> {
  InvAdjustmentInCreateRoute({
    _i12.Key? key,
    required String header,
    required _i14.InvAdjustmentInBloc invAdjInbloc,
  }) : super(
          InvAdjustmentInCreateRoute.name,
          path: 'create',
          args: InvAdjustmentInCreateRouteArgs(
            key: key,
            header: header,
            invAdjInbloc: invAdjInbloc,
          ),
        );

  static const String name = 'InvAdjustmentInCreateRoute';
}

class InvAdjustmentInCreateRouteArgs {
  const InvAdjustmentInCreateRouteArgs({
    this.key,
    required this.header,
    required this.invAdjInbloc,
  });

  final _i12.Key? key;

  final String header;

  final _i14.InvAdjustmentInBloc invAdjInbloc;

  @override
  String toString() {
    return 'InvAdjustmentInCreateRouteArgs{key: $key, header: $header, invAdjInbloc: $invAdjInbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentInDetailsPage]
class InvAdjustmentInDetailsRoute
    extends _i9.PageRouteInfo<InvAdjustmentInDetailsRouteArgs> {
  InvAdjustmentInDetailsRoute({
    _i12.Key? key,
    required String header,
    required int id,
  }) : super(
          InvAdjustmentInDetailsRoute.name,
          path: 'details/:id',
          args: InvAdjustmentInDetailsRouteArgs(
            key: key,
            header: header,
            id: id,
          ),
        );

  static const String name = 'InvAdjustmentInDetailsRoute';
}

class InvAdjustmentInDetailsRouteArgs {
  const InvAdjustmentInDetailsRouteArgs({
    this.key,
    required this.header,
    required this.id,
  });

  final _i12.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentInDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutPage]
class InvAdjustmentOutRoute extends _i9.PageRouteInfo<void> {
  const InvAdjustmentOutRoute()
      : super(
          InvAdjustmentOutRoute.name,
          path: '',
        );

  static const String name = 'InvAdjustmentOutRoute';
}

/// generated route for
/// [_i1.InvAdjustmentOutFormPage]
class InvAdjustmentOutCreateRoute
    extends _i9.PageRouteInfo<InvAdjustmentOutCreateRouteArgs> {
  InvAdjustmentOutCreateRoute({
    _i12.Key? key,
    required String header,
    required _i15.InvAdjustmentOutBloc invAdjOutbloc,
  }) : super(
          InvAdjustmentOutCreateRoute.name,
          path: 'create',
          args: InvAdjustmentOutCreateRouteArgs(
            key: key,
            header: header,
            invAdjOutbloc: invAdjOutbloc,
          ),
        );

  static const String name = 'InvAdjustmentOutCreateRoute';
}

class InvAdjustmentOutCreateRouteArgs {
  const InvAdjustmentOutCreateRouteArgs({
    this.key,
    required this.header,
    required this.invAdjOutbloc,
  });

  final _i12.Key? key;

  final String header;

  final _i15.InvAdjustmentOutBloc invAdjOutbloc;

  @override
  String toString() {
    return 'InvAdjustmentOutCreateRouteArgs{key: $key, header: $header, invAdjOutbloc: $invAdjOutbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutDetailsPage]
class InvAdjustmentOutDetailsRoute
    extends _i9.PageRouteInfo<InvAdjustmentOutDetailsRouteArgs> {
  InvAdjustmentOutDetailsRoute({
    _i12.Key? key,
    required String header,
    required int id,
  }) : super(
          InvAdjustmentOutDetailsRoute.name,
          path: 'details/:id',
          args: InvAdjustmentOutDetailsRouteArgs(
            key: key,
            header: header,
            id: id,
          ),
        );

  static const String name = 'InvAdjustmentOutDetailsRoute';
}

class InvAdjustmentOutDetailsRouteArgs {
  const InvAdjustmentOutDetailsRouteArgs({
    this.key,
    required this.header,
    required this.id,
  });

  final _i12.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentOutDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.MasterDataMenuPage]
class MasterDataMenuRoute extends _i9.PageRouteInfo<void> {
  const MasterDataMenuRoute()
      : super(
          MasterDataMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'MasterDataMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SystemUsersWrapper extends _i9.PageRouteInfo<void> {
  const SystemUsersWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          SystemUsersWrapper.name,
          path: 'systemUsers',
          initialChildren: children,
        );

  static const String name = 'SystemUsersWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CustomerWrapper extends _i9.PageRouteInfo<void> {
  const CustomerWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          CustomerWrapper.name,
          path: 'customer',
          initialChildren: children,
        );

  static const String name = 'CustomerWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class BranchesWrapper extends _i9.PageRouteInfo<void> {
  const BranchesWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          BranchesWrapper.name,
          path: 'branches',
          initialChildren: children,
        );

  static const String name = 'BranchesWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class UomsWrapper extends _i9.PageRouteInfo<void> {
  const UomsWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          UomsWrapper.name,
          path: 'uoms',
          initialChildren: children,
        );

  static const String name = 'UomsWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class PricelistWrapper extends _i9.PageRouteInfo<void> {
  const PricelistWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          PricelistWrapper.name,
          path: 'pricelist',
          initialChildren: children,
        );

  static const String name = 'PricelistWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ItemWrapper extends _i9.PageRouteInfo<void> {
  const ItemWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          ItemWrapper.name,
          path: 'items',
          initialChildren: children,
        );

  static const String name = 'ItemWrapper';
}

/// generated route for
/// [_i1.SystemUsersPage]
class SystemUsersRoute extends _i9.PageRouteInfo<void> {
  const SystemUsersRoute()
      : super(
          SystemUsersRoute.name,
          path: '',
        );

  static const String name = 'SystemUsersRoute';
}

/// generated route for
/// [_i1.SystemUserCreateFormPage]
class SystemUserCreateFormRoute extends _i9.PageRouteInfo<void> {
  const SystemUserCreateFormRoute()
      : super(
          SystemUserCreateFormRoute.name,
          path: 'create',
        );

  static const String name = 'SystemUserCreateFormRoute';
}

/// generated route for
/// [_i1.SystemUserUpdateFormPage]
class SystemUserUpdateFormRoute
    extends _i9.PageRouteInfo<SystemUserUpdateFormRouteArgs> {
  SystemUserUpdateFormRoute({
    _i12.Key? key,
    _i13.SystemUserModel? selectedSystemUser,
  }) : super(
          SystemUserUpdateFormRoute.name,
          path: 'edit',
          args: SystemUserUpdateFormRouteArgs(
            key: key,
            selectedSystemUser: selectedSystemUser,
          ),
        );

  static const String name = 'SystemUserUpdateFormRoute';
}

class SystemUserUpdateFormRouteArgs {
  const SystemUserUpdateFormRouteArgs({
    this.key,
    this.selectedSystemUser,
  });

  final _i12.Key? key;

  final _i13.SystemUserModel? selectedSystemUser;

  @override
  String toString() {
    return 'SystemUserUpdateFormRouteArgs{key: $key, selectedSystemUser: $selectedSystemUser}';
  }
}

/// generated route for
/// [_i7.CustomersPage]
class CustomersRoute extends _i9.PageRouteInfo<void> {
  const CustomersRoute()
      : super(
          CustomersRoute.name,
          path: '',
        );

  static const String name = 'CustomersRoute';
}

/// generated route for
/// [_i8.CustomerFormPage]
class CustomerFormRoute extends _i9.PageRouteInfo<CustomerFormRouteArgs> {
  CustomerFormRoute({
    _i12.Key? key,
    required String header,
  }) : super(
          CustomerFormRoute.name,
          path: 'create',
          args: CustomerFormRouteArgs(
            key: key,
            header: header,
          ),
        );

  static const String name = 'CustomerFormRoute';
}

class CustomerFormRouteArgs {
  const CustomerFormRouteArgs({
    this.key,
    required this.header,
  });

  final _i12.Key? key;

  final String header;

  @override
  String toString() {
    return 'CustomerFormRouteArgs{key: $key, header: $header}';
  }
}

/// generated route for
/// [_i1.BranchesPage]
class BranchesRoute extends _i9.PageRouteInfo<void> {
  const BranchesRoute()
      : super(
          BranchesRoute.name,
          path: '',
        );

  static const String name = 'BranchesRoute';
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchCreateRoute extends _i9.PageRouteInfo<BranchCreateRouteArgs> {
  BranchCreateRoute({
    _i12.Key? key,
    required String header,
    _i13.BranchModel? selectedBranch,
  }) : super(
          BranchCreateRoute.name,
          path: 'create',
          args: BranchCreateRouteArgs(
            key: key,
            header: header,
            selectedBranch: selectedBranch,
          ),
        );

  static const String name = 'BranchCreateRoute';
}

class BranchCreateRouteArgs {
  const BranchCreateRouteArgs({
    this.key,
    required this.header,
    this.selectedBranch,
  });

  final _i12.Key? key;

  final String header;

  final _i13.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchCreateRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchEditRoute extends _i9.PageRouteInfo<BranchEditRouteArgs> {
  BranchEditRoute({
    _i12.Key? key,
    required String header,
    _i13.BranchModel? selectedBranch,
  }) : super(
          BranchEditRoute.name,
          path: 'edit',
          args: BranchEditRouteArgs(
            key: key,
            header: header,
            selectedBranch: selectedBranch,
          ),
        );

  static const String name = 'BranchEditRoute';
}

class BranchEditRouteArgs {
  const BranchEditRouteArgs({
    this.key,
    required this.header,
    this.selectedBranch,
  });

  final _i12.Key? key;

  final String header;

  final _i13.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchEditRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.UomsPage]
class UomsRoute extends _i9.PageRouteInfo<void> {
  const UomsRoute()
      : super(
          UomsRoute.name,
          path: '',
        );

  static const String name = 'UomsRoute';
}

/// generated route for
/// [_i1.UomFormPage]
class UomCreateRoute extends _i9.PageRouteInfo<UomCreateRouteArgs> {
  UomCreateRoute({
    _i12.Key? key,
    required String header,
    _i13.UomModel? selectedUom,
  }) : super(
          UomCreateRoute.name,
          path: 'create',
          args: UomCreateRouteArgs(
            key: key,
            header: header,
            selectedUom: selectedUom,
          ),
        );

  static const String name = 'UomCreateRoute';
}

class UomCreateRouteArgs {
  const UomCreateRouteArgs({
    this.key,
    required this.header,
    this.selectedUom,
  });

  final _i12.Key? key;

  final String header;

  final _i13.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomCreateRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i1.UomFormPage]
class UomEditRoute extends _i9.PageRouteInfo<UomEditRouteArgs> {
  UomEditRoute({
    _i12.Key? key,
    required String header,
    _i13.UomModel? selectedUom,
  }) : super(
          UomEditRoute.name,
          path: 'edit',
          args: UomEditRouteArgs(
            key: key,
            header: header,
            selectedUom: selectedUom,
          ),
        );

  static const String name = 'UomEditRoute';
}

class UomEditRouteArgs {
  const UomEditRouteArgs({
    this.key,
    required this.header,
    this.selectedUom,
  });

  final _i12.Key? key;

  final String header;

  final _i13.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomEditRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i1.PricelistPage]
class PricelistRoute extends _i9.PageRouteInfo<void> {
  const PricelistRoute()
      : super(
          PricelistRoute.name,
          path: '',
        );

  static const String name = 'PricelistRoute';
}

/// generated route for
/// [_i1.PricelistFormPage]
class PricelistCreateRoute extends _i9.PageRouteInfo<PricelistCreateRouteArgs> {
  PricelistCreateRoute({
    _i12.Key? key,
    required String header,
    _i13.PricelistModel? selectedPricelist,
    required _i16.Future<void> Function() refresh,
  }) : super(
          PricelistCreateRoute.name,
          path: 'create',
          args: PricelistCreateRouteArgs(
            key: key,
            header: header,
            selectedPricelist: selectedPricelist,
            refresh: refresh,
          ),
        );

  static const String name = 'PricelistCreateRoute';
}

class PricelistCreateRouteArgs {
  const PricelistCreateRouteArgs({
    this.key,
    required this.header,
    this.selectedPricelist,
    required this.refresh,
  });

  final _i12.Key? key;

  final String header;

  final _i13.PricelistModel? selectedPricelist;

  final _i16.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistCreateRouteArgs{key: $key, header: $header, selectedPricelist: $selectedPricelist, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.PricelistRowPage]
class PricelistRowRoute extends _i9.PageRouteInfo<PricelistRowRouteArgs> {
  PricelistRowRoute({
    _i12.Key? key,
    required _i13.PricelistModel pricelistModel,
    required _i16.Future<void> Function() refresh,
  }) : super(
          PricelistRowRoute.name,
          path: 'pricelist_row',
          args: PricelistRowRouteArgs(
            key: key,
            pricelistModel: pricelistModel,
            refresh: refresh,
          ),
        );

  static const String name = 'PricelistRowRoute';
}

class PricelistRowRouteArgs {
  const PricelistRowRouteArgs({
    this.key,
    required this.pricelistModel,
    required this.refresh,
  });

  final _i12.Key? key;

  final _i13.PricelistModel pricelistModel;

  final _i16.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistRowRouteArgs{key: $key, pricelistModel: $pricelistModel, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.ItemsPage]
class ItemsRoute extends _i9.PageRouteInfo<void> {
  const ItemsRoute()
      : super(
          ItemsRoute.name,
          path: '',
        );

  static const String name = 'ItemsRoute';
}

/// generated route for
/// [_i1.ItemFormPage]
class ItemCreatePage extends _i9.PageRouteInfo<ItemCreatePageArgs> {
  ItemCreatePage({
    _i12.Key? key,
    required String header,
    _i13.ProductModel? selectedItem,
  }) : super(
          ItemCreatePage.name,
          path: 'create',
          args: ItemCreatePageArgs(
            key: key,
            header: header,
            selectedItem: selectedItem,
          ),
        );

  static const String name = 'ItemCreatePage';
}

class ItemCreatePageArgs {
  const ItemCreatePageArgs({
    this.key,
    required this.header,
    this.selectedItem,
  });

  final _i12.Key? key;

  final String header;

  final _i13.ProductModel? selectedItem;

  @override
  String toString() {
    return 'ItemCreatePageArgs{key: $key, header: $header, selectedItem: $selectedItem}';
  }
}

/// generated route for
/// [_i1.ItemFormPage]
class ItemEditPage extends _i9.PageRouteInfo<ItemEditPageArgs> {
  ItemEditPage({
    _i12.Key? key,
    required String header,
    _i13.ProductModel? selectedItem,
  }) : super(
          ItemEditPage.name,
          path: 'edit',
          args: ItemEditPageArgs(
            key: key,
            header: header,
            selectedItem: selectedItem,
          ),
        );

  static const String name = 'ItemEditPage';
}

class ItemEditPageArgs {
  const ItemEditPageArgs({
    this.key,
    required this.header,
    this.selectedItem,
  });

  final _i12.Key? key;

  final String header;

  final _i13.ProductModel? selectedItem;

  @override
  String toString() {
    return 'ItemEditPageArgs{key: $key, header: $header, selectedItem: $selectedItem}';
  }
}
