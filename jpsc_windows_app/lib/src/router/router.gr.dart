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
import 'dart:async' as _i18;

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:fluent_ui/fluent_ui.dart' as _i14;
import 'package:flutter/material.dart' as _i12;

import '../data/models/models.dart' as _i15;
import '../pages/exports.dart' as _i1;
import '../pages/menu_inventory/menus/inv_adj_in/bloc/inv_adj_in_bloc.dart'
    as _i16;
import '../pages/menu_inventory/menus/inv_adj_out/bloc/inv_adj_out_bloc.dart'
    as _i17;
import '../pages/menu_master_data/menus/customers/customers.dart' as _i7;
import '../pages/menu_master_data/menus/customers/widgets/form/customer_form.dart'
    as _i8;
import '../pages/menu_master_data/menus/payment_terms/components/form.dart'
    as _i10;
import '../pages/menu_master_data/menus/payment_terms/payment_terms.dart'
    as _i9;
import '../pages/menu_sales/main.dart' as _i2;
import '../pages/menu_sales/modules/price_quotation/components/details/pq_details.dart'
    as _i6;
import '../pages/menu_sales/modules/price_quotation/price_quotation.dart'
    as _i5;
import '../pages/menu_sales/sales_menu.dart' as _i3;
import 'router_guard.dart' as _i13;

class AppRouter extends _i11.RootStackRouter {
  AppRouter({
    _i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
    required this.routeGuard,
  }) : super(navigatorKey);

  final _i13.RouteGuard routeGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PurchasingMenuRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PurchasingMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuWrapperRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.SalesMenuWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryWrapperRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    MasterDataWrapperRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataWrapperPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.SalesMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.PriceQuotationPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationHeaderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PriceQuotationHeaderDetailsRouteArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.PriceQuotationHeaderDetailsPage(
          key: args.key,
          header: args.header,
          priceQuotation: args.priceQuotation,
          onRefresh: args.onRefresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryMenuRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjInWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjOutWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentInRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentInPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentInCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentInCreateRouteArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentOutPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    InvAdjustmentOutCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentOutCreateRouteArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataMenuPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermWrapper.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUsersPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserCreateFormRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUserCreateFormPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserUpdateFormRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUserUpdateFormRouteArgs>(
          orElse: () => const SystemUserUpdateFormRouteArgs());
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.CustomersPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerFormRouteArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.CustomerFormPage(
          key: args.key,
          header: args.header,
          selectedCustomer: args.selectedCustomer,
          onRefresh: args.onRefresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BranchesPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BranchCreateRouteArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UomsPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomCreateRoute.name: (routeData) {
      final args = routeData.argsAs<UomCreateRouteArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PricelistPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistCreateRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistCreateRouteArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ItemsPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemCreatePage.name: (routeData) {
      final args = routeData.argsAs<ItemCreatePageArgs>();
      return _i11.CustomPage<dynamic>(
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
      return _i11.CustomPage<dynamic>(
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
    PaymentTermsRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.PaymentTermsPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermFormRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentTermFormRouteArgs>();
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.PaymentTermFormPage(
          key: args.key,
          header: args.header,
          selectedPayTermObj: args.selectedPayTermObj,
          onRefresh: args.onRefresh,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i11.RouteConfig(
          MainRoute.name,
          path: '/',
          guards: [routeGuard],
          children: [
            _i11.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i11.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i11.RouteConfig(
              PurchasingMenuRoute.name,
              path: 'purchasing',
              parent: MainRoute.name,
            ),
            _i11.RouteConfig(
              SalesMenuWrapperRoute.name,
              path: 'sales',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: SalesMenuWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i11.RouteConfig(
                  SalesMenuRoute.name,
                  path: 'menu',
                  parent: SalesMenuWrapperRoute.name,
                ),
                _i11.RouteConfig(
                  PriceQuotationWrapper.name,
                  path: 'sales_order',
                  parent: SalesMenuWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      PriceQuotationRoute.name,
                      path: '',
                      parent: PriceQuotationWrapper.name,
                    ),
                    _i11.RouteConfig(
                      PriceQuotationHeaderDetailsRoute.name,
                      path: '',
                      parent: PriceQuotationWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i11.RouteConfig(
              InventoryWrapperRoute.name,
              path: 'inventory',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: InventoryWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i11.RouteConfig(
                  InventoryMenuRoute.name,
                  path: 'menu',
                  parent: InventoryWrapperRoute.name,
                ),
                _i11.RouteConfig(
                  InvAdjInWrapper.name,
                  path: 'inv_adj_in',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      InvAdjustmentInRoute.name,
                      path: '',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i11.RouteConfig(
                      InvAdjustmentInCreateRoute.name,
                      path: 'create',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i11.RouteConfig(
                      InvAdjustmentInDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjInWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  InvAdjOutWrapper.name,
                  path: 'inv_adj_out',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      InvAdjustmentOutRoute.name,
                      path: '',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i11.RouteConfig(
                      InvAdjustmentOutCreateRoute.name,
                      path: 'create',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i11.RouteConfig(
                      InvAdjustmentOutDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjOutWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i11.RouteConfig(
              MasterDataWrapperRoute.name,
              path: 'master_data',
              parent: MainRoute.name,
              children: [
                _i11.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MasterDataWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i11.RouteConfig(
                  MasterDataMenuRoute.name,
                  path: 'menu',
                  parent: MasterDataWrapperRoute.name,
                ),
                _i11.RouteConfig(
                  SystemUsersWrapper.name,
                  path: 'systemUsers',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      SystemUsersRoute.name,
                      path: '',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i11.RouteConfig(
                      SystemUserCreateFormRoute.name,
                      path: 'create',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i11.RouteConfig(
                      SystemUserUpdateFormRoute.name,
                      path: 'edit',
                      parent: SystemUsersWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  CustomerWrapper.name,
                  path: 'customer',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      CustomersRoute.name,
                      path: '',
                      parent: CustomerWrapper.name,
                    ),
                    _i11.RouteConfig(
                      CustomerFormRoute.name,
                      path: 'create',
                      parent: CustomerWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  BranchesWrapper.name,
                  path: 'branches',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      BranchesRoute.name,
                      path: '',
                      parent: BranchesWrapper.name,
                    ),
                    _i11.RouteConfig(
                      BranchCreateRoute.name,
                      path: 'create',
                      parent: BranchesWrapper.name,
                    ),
                    _i11.RouteConfig(
                      BranchEditRoute.name,
                      path: 'edit',
                      parent: BranchesWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  UomsWrapper.name,
                  path: 'uoms',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      UomsRoute.name,
                      path: '',
                      parent: UomsWrapper.name,
                    ),
                    _i11.RouteConfig(
                      UomCreateRoute.name,
                      path: 'create',
                      parent: UomsWrapper.name,
                    ),
                    _i11.RouteConfig(
                      UomEditRoute.name,
                      path: 'edit',
                      parent: UomsWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  PricelistWrapper.name,
                  path: 'pricelist',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      PricelistRoute.name,
                      path: '',
                      parent: PricelistWrapper.name,
                    ),
                    _i11.RouteConfig(
                      PricelistCreateRoute.name,
                      path: 'create',
                      parent: PricelistWrapper.name,
                    ),
                    _i11.RouteConfig(
                      PricelistRowRoute.name,
                      path: 'pricelist_row',
                      parent: PricelistWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  ItemWrapper.name,
                  path: 'items',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      ItemsRoute.name,
                      path: '',
                      parent: ItemWrapper.name,
                    ),
                    _i11.RouteConfig(
                      ItemCreatePage.name,
                      path: 'create',
                      parent: ItemWrapper.name,
                    ),
                    _i11.RouteConfig(
                      ItemEditPage.name,
                      path: 'edit',
                      parent: ItemWrapper.name,
                    ),
                  ],
                ),
                _i11.RouteConfig(
                  PaymentTermWrapper.name,
                  path: 'payment_term',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(
                      PaymentTermsRoute.name,
                      path: '',
                      parent: PaymentTermWrapper.name,
                    ),
                    _i11.RouteConfig(
                      PaymentTermFormRoute.name,
                      path: 'form',
                      parent: PaymentTermWrapper.name,
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
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.PurchasingMenuPage]
class PurchasingMenuRoute extends _i11.PageRouteInfo<void> {
  const PurchasingMenuRoute()
      : super(
          PurchasingMenuRoute.name,
          path: 'purchasing',
        );

  static const String name = 'PurchasingMenuRoute';
}

/// generated route for
/// [_i2.SalesMenuWrapperPage]
class SalesMenuWrapperRoute extends _i11.PageRouteInfo<void> {
  const SalesMenuWrapperRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SalesMenuWrapperRoute.name,
          path: 'sales',
          initialChildren: children,
        );

  static const String name = 'SalesMenuWrapperRoute';
}

/// generated route for
/// [_i1.InventoryWrapperPage]
class InventoryWrapperRoute extends _i11.PageRouteInfo<void> {
  const InventoryWrapperRoute({List<_i11.PageRouteInfo>? children})
      : super(
          InventoryWrapperRoute.name,
          path: 'inventory',
          initialChildren: children,
        );

  static const String name = 'InventoryWrapperRoute';
}

/// generated route for
/// [_i1.MasterDataWrapperPage]
class MasterDataWrapperRoute extends _i11.PageRouteInfo<void> {
  const MasterDataWrapperRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MasterDataWrapperRoute.name,
          path: 'master_data',
          initialChildren: children,
        );

  static const String name = 'MasterDataWrapperRoute';
}

/// generated route for
/// [_i3.SalesMenuPage]
class SalesMenuRoute extends _i11.PageRouteInfo<void> {
  const SalesMenuRoute()
      : super(
          SalesMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'SalesMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class PriceQuotationWrapper extends _i11.PageRouteInfo<void> {
  const PriceQuotationWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          PriceQuotationWrapper.name,
          path: 'sales_order',
          initialChildren: children,
        );

  static const String name = 'PriceQuotationWrapper';
}

/// generated route for
/// [_i5.PriceQuotationPage]
class PriceQuotationRoute extends _i11.PageRouteInfo<void> {
  const PriceQuotationRoute()
      : super(
          PriceQuotationRoute.name,
          path: '',
        );

  static const String name = 'PriceQuotationRoute';
}

/// generated route for
/// [_i6.PriceQuotationHeaderDetailsPage]
class PriceQuotationHeaderDetailsRoute
    extends _i11.PageRouteInfo<PriceQuotationHeaderDetailsRouteArgs> {
  PriceQuotationHeaderDetailsRoute({
    _i14.Key? key,
    required String header,
    required _i15.PriceQuotationModel priceQuotation,
    required void Function() onRefresh,
  }) : super(
          PriceQuotationHeaderDetailsRoute.name,
          path: '',
          args: PriceQuotationHeaderDetailsRouteArgs(
            key: key,
            header: header,
            priceQuotation: priceQuotation,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'PriceQuotationHeaderDetailsRoute';
}

class PriceQuotationHeaderDetailsRouteArgs {
  const PriceQuotationHeaderDetailsRouteArgs({
    this.key,
    required this.header,
    required this.priceQuotation,
    required this.onRefresh,
  });

  final _i14.Key? key;

  final String header;

  final _i15.PriceQuotationModel priceQuotation;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'PriceQuotationHeaderDetailsRouteArgs{key: $key, header: $header, priceQuotation: $priceQuotation, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.InventoryMenuPage]
class InventoryMenuRoute extends _i11.PageRouteInfo<void> {
  const InventoryMenuRoute()
      : super(
          InventoryMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'InventoryMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class InvAdjInWrapper extends _i11.PageRouteInfo<void> {
  const InvAdjInWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          InvAdjInWrapper.name,
          path: 'inv_adj_in',
          initialChildren: children,
        );

  static const String name = 'InvAdjInWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class InvAdjOutWrapper extends _i11.PageRouteInfo<void> {
  const InvAdjOutWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          InvAdjOutWrapper.name,
          path: 'inv_adj_out',
          initialChildren: children,
        );

  static const String name = 'InvAdjOutWrapper';
}

/// generated route for
/// [_i1.InvAdjustmentInPage]
class InvAdjustmentInRoute extends _i11.PageRouteInfo<void> {
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
    extends _i11.PageRouteInfo<InvAdjustmentInCreateRouteArgs> {
  InvAdjustmentInCreateRoute({
    _i14.Key? key,
    required String header,
    required _i16.InvAdjustmentInBloc invAdjInbloc,
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

  final _i14.Key? key;

  final String header;

  final _i16.InvAdjustmentInBloc invAdjInbloc;

  @override
  String toString() {
    return 'InvAdjustmentInCreateRouteArgs{key: $key, header: $header, invAdjInbloc: $invAdjInbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentInDetailsPage]
class InvAdjustmentInDetailsRoute
    extends _i11.PageRouteInfo<InvAdjustmentInDetailsRouteArgs> {
  InvAdjustmentInDetailsRoute({
    _i14.Key? key,
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

  final _i14.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentInDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutPage]
class InvAdjustmentOutRoute extends _i11.PageRouteInfo<void> {
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
    extends _i11.PageRouteInfo<InvAdjustmentOutCreateRouteArgs> {
  InvAdjustmentOutCreateRoute({
    _i14.Key? key,
    required String header,
    required _i17.InvAdjustmentOutBloc invAdjOutbloc,
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

  final _i14.Key? key;

  final String header;

  final _i17.InvAdjustmentOutBloc invAdjOutbloc;

  @override
  String toString() {
    return 'InvAdjustmentOutCreateRouteArgs{key: $key, header: $header, invAdjOutbloc: $invAdjOutbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutDetailsPage]
class InvAdjustmentOutDetailsRoute
    extends _i11.PageRouteInfo<InvAdjustmentOutDetailsRouteArgs> {
  InvAdjustmentOutDetailsRoute({
    _i14.Key? key,
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

  final _i14.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentOutDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.MasterDataMenuPage]
class MasterDataMenuRoute extends _i11.PageRouteInfo<void> {
  const MasterDataMenuRoute()
      : super(
          MasterDataMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'MasterDataMenuRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SystemUsersWrapper extends _i11.PageRouteInfo<void> {
  const SystemUsersWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          SystemUsersWrapper.name,
          path: 'systemUsers',
          initialChildren: children,
        );

  static const String name = 'SystemUsersWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CustomerWrapper extends _i11.PageRouteInfo<void> {
  const CustomerWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          CustomerWrapper.name,
          path: 'customer',
          initialChildren: children,
        );

  static const String name = 'CustomerWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class BranchesWrapper extends _i11.PageRouteInfo<void> {
  const BranchesWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          BranchesWrapper.name,
          path: 'branches',
          initialChildren: children,
        );

  static const String name = 'BranchesWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class UomsWrapper extends _i11.PageRouteInfo<void> {
  const UomsWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          UomsWrapper.name,
          path: 'uoms',
          initialChildren: children,
        );

  static const String name = 'UomsWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class PricelistWrapper extends _i11.PageRouteInfo<void> {
  const PricelistWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          PricelistWrapper.name,
          path: 'pricelist',
          initialChildren: children,
        );

  static const String name = 'PricelistWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ItemWrapper extends _i11.PageRouteInfo<void> {
  const ItemWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          ItemWrapper.name,
          path: 'items',
          initialChildren: children,
        );

  static const String name = 'ItemWrapper';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class PaymentTermWrapper extends _i11.PageRouteInfo<void> {
  const PaymentTermWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          PaymentTermWrapper.name,
          path: 'payment_term',
          initialChildren: children,
        );

  static const String name = 'PaymentTermWrapper';
}

/// generated route for
/// [_i1.SystemUsersPage]
class SystemUsersRoute extends _i11.PageRouteInfo<void> {
  const SystemUsersRoute()
      : super(
          SystemUsersRoute.name,
          path: '',
        );

  static const String name = 'SystemUsersRoute';
}

/// generated route for
/// [_i1.SystemUserCreateFormPage]
class SystemUserCreateFormRoute extends _i11.PageRouteInfo<void> {
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
    extends _i11.PageRouteInfo<SystemUserUpdateFormRouteArgs> {
  SystemUserUpdateFormRoute({
    _i14.Key? key,
    _i15.SystemUserModel? selectedSystemUser,
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

  final _i14.Key? key;

  final _i15.SystemUserModel? selectedSystemUser;

  @override
  String toString() {
    return 'SystemUserUpdateFormRouteArgs{key: $key, selectedSystemUser: $selectedSystemUser}';
  }
}

/// generated route for
/// [_i7.CustomersPage]
class CustomersRoute extends _i11.PageRouteInfo<void> {
  const CustomersRoute()
      : super(
          CustomersRoute.name,
          path: '',
        );

  static const String name = 'CustomersRoute';
}

/// generated route for
/// [_i8.CustomerFormPage]
class CustomerFormRoute extends _i11.PageRouteInfo<CustomerFormRouteArgs> {
  CustomerFormRoute({
    _i14.Key? key,
    required String header,
    _i15.CustomerModel? selectedCustomer,
    required void Function() onRefresh,
  }) : super(
          CustomerFormRoute.name,
          path: 'create',
          args: CustomerFormRouteArgs(
            key: key,
            header: header,
            selectedCustomer: selectedCustomer,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'CustomerFormRoute';
}

class CustomerFormRouteArgs {
  const CustomerFormRouteArgs({
    this.key,
    required this.header,
    this.selectedCustomer,
    required this.onRefresh,
  });

  final _i14.Key? key;

  final String header;

  final _i15.CustomerModel? selectedCustomer;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'CustomerFormRouteArgs{key: $key, header: $header, selectedCustomer: $selectedCustomer, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.BranchesPage]
class BranchesRoute extends _i11.PageRouteInfo<void> {
  const BranchesRoute()
      : super(
          BranchesRoute.name,
          path: '',
        );

  static const String name = 'BranchesRoute';
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchCreateRoute extends _i11.PageRouteInfo<BranchCreateRouteArgs> {
  BranchCreateRoute({
    _i14.Key? key,
    required String header,
    _i15.BranchModel? selectedBranch,
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

  final _i14.Key? key;

  final String header;

  final _i15.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchCreateRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchEditRoute extends _i11.PageRouteInfo<BranchEditRouteArgs> {
  BranchEditRoute({
    _i14.Key? key,
    required String header,
    _i15.BranchModel? selectedBranch,
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

  final _i14.Key? key;

  final String header;

  final _i15.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchEditRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.UomsPage]
class UomsRoute extends _i11.PageRouteInfo<void> {
  const UomsRoute()
      : super(
          UomsRoute.name,
          path: '',
        );

  static const String name = 'UomsRoute';
}

/// generated route for
/// [_i1.UomFormPage]
class UomCreateRoute extends _i11.PageRouteInfo<UomCreateRouteArgs> {
  UomCreateRoute({
    _i14.Key? key,
    required String header,
    _i15.UomModel? selectedUom,
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

  final _i14.Key? key;

  final String header;

  final _i15.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomCreateRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i1.UomFormPage]
class UomEditRoute extends _i11.PageRouteInfo<UomEditRouteArgs> {
  UomEditRoute({
    _i14.Key? key,
    required String header,
    _i15.UomModel? selectedUom,
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

  final _i14.Key? key;

  final String header;

  final _i15.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomEditRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i1.PricelistPage]
class PricelistRoute extends _i11.PageRouteInfo<void> {
  const PricelistRoute()
      : super(
          PricelistRoute.name,
          path: '',
        );

  static const String name = 'PricelistRoute';
}

/// generated route for
/// [_i1.PricelistFormPage]
class PricelistCreateRoute
    extends _i11.PageRouteInfo<PricelistCreateRouteArgs> {
  PricelistCreateRoute({
    _i14.Key? key,
    required String header,
    _i15.PricelistModel? selectedPricelist,
    required _i18.Future<void> Function() refresh,
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

  final _i14.Key? key;

  final String header;

  final _i15.PricelistModel? selectedPricelist;

  final _i18.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistCreateRouteArgs{key: $key, header: $header, selectedPricelist: $selectedPricelist, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.PricelistRowPage]
class PricelistRowRoute extends _i11.PageRouteInfo<PricelistRowRouteArgs> {
  PricelistRowRoute({
    _i14.Key? key,
    required _i15.PricelistModel pricelistModel,
    required _i18.Future<void> Function() refresh,
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

  final _i14.Key? key;

  final _i15.PricelistModel pricelistModel;

  final _i18.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistRowRouteArgs{key: $key, pricelistModel: $pricelistModel, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.ItemsPage]
class ItemsRoute extends _i11.PageRouteInfo<void> {
  const ItemsRoute()
      : super(
          ItemsRoute.name,
          path: '',
        );

  static const String name = 'ItemsRoute';
}

/// generated route for
/// [_i1.ItemFormPage]
class ItemCreatePage extends _i11.PageRouteInfo<ItemCreatePageArgs> {
  ItemCreatePage({
    _i14.Key? key,
    required String header,
    _i15.ProductModel? selectedItem,
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

  final _i14.Key? key;

  final String header;

  final _i15.ProductModel? selectedItem;

  @override
  String toString() {
    return 'ItemCreatePageArgs{key: $key, header: $header, selectedItem: $selectedItem}';
  }
}

/// generated route for
/// [_i1.ItemFormPage]
class ItemEditPage extends _i11.PageRouteInfo<ItemEditPageArgs> {
  ItemEditPage({
    _i14.Key? key,
    required String header,
    _i15.ProductModel? selectedItem,
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

  final _i14.Key? key;

  final String header;

  final _i15.ProductModel? selectedItem;

  @override
  String toString() {
    return 'ItemEditPageArgs{key: $key, header: $header, selectedItem: $selectedItem}';
  }
}

/// generated route for
/// [_i9.PaymentTermsPage]
class PaymentTermsRoute extends _i11.PageRouteInfo<void> {
  const PaymentTermsRoute()
      : super(
          PaymentTermsRoute.name,
          path: '',
        );

  static const String name = 'PaymentTermsRoute';
}

/// generated route for
/// [_i10.PaymentTermFormPage]
class PaymentTermFormRoute
    extends _i11.PageRouteInfo<PaymentTermFormRouteArgs> {
  PaymentTermFormRoute({
    _i14.Key? key,
    required String header,
    _i15.PaymentTermModel? selectedPayTermObj,
    required void Function() onRefresh,
  }) : super(
          PaymentTermFormRoute.name,
          path: 'form',
          args: PaymentTermFormRouteArgs(
            key: key,
            header: header,
            selectedPayTermObj: selectedPayTermObj,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'PaymentTermFormRoute';
}

class PaymentTermFormRouteArgs {
  const PaymentTermFormRouteArgs({
    this.key,
    required this.header,
    this.selectedPayTermObj,
    required this.onRefresh,
  });

  final _i14.Key? key;

  final String header;

  final _i15.PaymentTermModel? selectedPayTermObj;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'PaymentTermFormRouteArgs{key: $key, header: $header, selectedPayTermObj: $selectedPayTermObj, onRefresh: $onRefresh}';
  }
}
