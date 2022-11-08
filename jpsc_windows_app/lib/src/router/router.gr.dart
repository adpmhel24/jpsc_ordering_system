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
import 'dart:async' as _i26;

import 'package:auto_route/auto_route.dart' as _i19;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:fluent_ui/fluent_ui.dart' as _i22;
import 'package:flutter/material.dart' as _i20;
import 'package:jpsc_windows_app/src/data/models/models.dart' as _i23;
import 'package:jpsc_windows_app/src/pages/exports.dart' as _i1;
import 'package:jpsc_windows_app/src/pages/menu_inventory/menus/inv_adj_in/bloc/inv_adj_in_bloc.dart'
    as _i24;
import 'package:jpsc_windows_app/src/pages/menu_inventory/menus/inv_adj_out/bloc/inv_adj_out_bloc.dart'
    as _i25;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/components/form/customer_form.dart'
    as _i10;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/components/upload_page.dart'
    as _i11;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/customers.dart'
    as _i9;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/components/upload_page.dart'
    as _i15;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/form/form.dart'
    as _i14;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/item_group.dart'
    as _i13;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/payment_terms/components/form.dart'
    as _i18;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/payment_terms/payment_terms.dart'
    as _i17;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/products/widgets/upload_page.dart'
    as _i16;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/system_users/components/upload_page.dart'
    as _i8;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/uoms/widgets/uoms_to_upload.dart'
    as _i12;
import 'package:jpsc_windows_app/src/pages/menu_sales/main.dart' as _i2;
import 'package:jpsc_windows_app/src/pages/menu_sales/modules/price_quotation/components/details/pq_details.dart'
    as _i7;
import 'package:jpsc_windows_app/src/pages/menu_sales/modules/price_quotation/price_quotation.dart'
    as _i6;
import 'package:jpsc_windows_app/src/pages/menu_sales/sales_menu.dart' as _i4;
import 'package:jpsc_windows_app/src/pages/my_profile/my_profile_page.dart'
    as _i3;
import 'package:jpsc_windows_app/src/router/router_guard.dart' as _i21;

class AppRouter extends _i19.RootStackRouter {
  AppRouter({
    _i20.GlobalKey<_i20.NavigatorState>? navigatorKey,
    required this.routeGuard,
  }) : super(navigatorKey);

  final _i21.RouteGuard routeGuard;

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PurchasingMenuRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PurchasingMenuPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuWrapperRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.SalesMenuWrapperPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryWrapperRoute.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryWrapperPage(),
      );
    },
    MasterDataWrapperRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataWrapperPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.MyProfilePage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.SalesMenuPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.PriceQuotationPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationHeaderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PriceQuotationHeaderDetailsRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.PriceQuotationHeaderDetailsPage(
          key: args.key,
          header: args.header,
          priceQuotation: args.priceQuotation,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    InventoryMenuRoute.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.InventoryMenuPage(),
      );
    },
    InvAdjInWrapper.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    InvAdjOutWrapper.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
      );
    },
    InvAdjustmentInRoute.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentInPage(),
      );
    },
    InvAdjustmentInCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentInCreateRouteArgs>();
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentInFormPage(
          key: args.key,
          header: args.header,
          invAdjInbloc: args.invAdjInbloc,
        ),
      );
    },
    InvAdjustmentInDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentInDetailsRouteArgs>();
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentInDetailsPage(
          key: args.key,
          header: args.header,
          id: args.id,
        ),
      );
    },
    InvAdjustmentOutRoute.name: (routeData) {
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.InvAdjustmentOutPage(),
      );
    },
    InvAdjustmentOutCreateRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentOutCreateRouteArgs>();
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentOutFormPage(
          key: args.key,
          header: args.header,
          invAdjOutbloc: args.invAdjOutbloc,
        ),
      );
    },
    InvAdjustmentOutDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<InvAdjustmentOutDetailsRouteArgs>();
      return _i19.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.InvAdjustmentOutDetailsPage(
          key: args.key,
          header: args.header,
          id: args.id,
        ),
      );
    },
    MasterDataMenuRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataMenuPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermWrapper.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUsersPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserFormRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUserFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.SystemUserFormPage(
          key: args.key,
          selectedSystemUser: args.selectedSystemUser,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUsersToUploadRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.SystemUsersToUploadPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i9.CustomersPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.CustomerFormPage(
          key: args.key,
          header: args.header,
          selectedCustomer: args.selectedCustomer,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersBulkInsertRoute.name: (routeData) {
      final args = routeData.argsAs<CustomersBulkInsertRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.CustomersBulkInsertPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BranchesPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BranchCreateRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchEditRoute.name: (routeData) {
      final args = routeData.argsAs<BranchEditRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UomsPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomCreateRoute.name: (routeData) {
      final args = routeData.argsAs<UomCreateRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomEditRoute.name: (routeData) {
      final args = routeData.argsAs<UomEditRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<UomsToUploadRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.UomsToUploadPage(
          key: args.key,
          uoms: args.uoms,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i13.ItemGroupPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupFormRoute.name: (routeData) {
      final args = routeData.argsAs<ItemGroupFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.ItemGroupFormPage(
          key: args.key,
          header: args.header,
          selectedItemGroup: args.selectedItemGroup,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupsToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<ItemGroupsToUploadRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i15.ItemGroupsToUploadPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PricelistPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistFormRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistFormPage(
          key: args.key,
          header: args.header,
          selectedPricelist: args.selectedPricelist,
          refresh: args.refresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRowRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistRowRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistRowPage(
          key: args.key,
          pricelistCode: args.pricelistCode,
          itemCode: args.itemCode,
          refresh: args.refresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductFormRoute.name: (routeData) {
      final args = routeData.argsAs<ProductFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ProductFormPage(
          key: args.key,
          header: args.header,
          selectedItem: args.selectedItem,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductBulkInsertRoute.name: (routeData) {
      final args = routeData.argsAs<ProductBulkInsertRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i16.ProductBulkInsertPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermsRoute.name: (routeData) {
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i17.PaymentTermsPage(),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermFormRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentTermFormRouteArgs>();
      return _i19.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.PaymentTermFormPage(
          key: args.key,
          header: args.header,
          selectedPayTermObj: args.selectedPayTermObj,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i19.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i19.RouteConfig> get routes => [
        _i19.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i19.RouteConfig(
          MainRoute.name,
          path: '/',
          guards: [routeGuard],
          children: [
            _i19.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i19.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i19.RouteConfig(
              PurchasingMenuRoute.name,
              path: 'purchasing',
              parent: MainRoute.name,
            ),
            _i19.RouteConfig(
              SalesMenuWrapperRoute.name,
              path: 'sales',
              parent: MainRoute.name,
              children: [
                _i19.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: SalesMenuWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i19.RouteConfig(
                  SalesMenuRoute.name,
                  path: 'menu',
                  parent: SalesMenuWrapperRoute.name,
                ),
                _i19.RouteConfig(
                  PriceQuotationWrapper.name,
                  path: 'sales_order',
                  parent: SalesMenuWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      PriceQuotationRoute.name,
                      path: '',
                      parent: PriceQuotationWrapper.name,
                    ),
                    _i19.RouteConfig(
                      PriceQuotationHeaderDetailsRoute.name,
                      path: '',
                      parent: PriceQuotationWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i19.RouteConfig(
              InventoryWrapperRoute.name,
              path: 'inventory',
              parent: MainRoute.name,
              children: [
                _i19.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: InventoryWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i19.RouteConfig(
                  InventoryMenuRoute.name,
                  path: 'menu',
                  parent: InventoryWrapperRoute.name,
                ),
                _i19.RouteConfig(
                  InvAdjInWrapper.name,
                  path: 'inv_adj_in',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      InvAdjustmentInRoute.name,
                      path: '',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i19.RouteConfig(
                      InvAdjustmentInCreateRoute.name,
                      path: 'create',
                      parent: InvAdjInWrapper.name,
                    ),
                    _i19.RouteConfig(
                      InvAdjustmentInDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjInWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  InvAdjOutWrapper.name,
                  path: 'inv_adj_out',
                  parent: InventoryWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      InvAdjustmentOutRoute.name,
                      path: '',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i19.RouteConfig(
                      InvAdjustmentOutCreateRoute.name,
                      path: 'create',
                      parent: InvAdjOutWrapper.name,
                    ),
                    _i19.RouteConfig(
                      InvAdjustmentOutDetailsRoute.name,
                      path: 'details/:id',
                      parent: InvAdjOutWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i19.RouteConfig(
              MasterDataWrapperRoute.name,
              path: 'master_data',
              parent: MainRoute.name,
              children: [
                _i19.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MasterDataWrapperRoute.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i19.RouteConfig(
                  MasterDataMenuRoute.name,
                  path: 'menu',
                  parent: MasterDataWrapperRoute.name,
                ),
                _i19.RouteConfig(
                  SystemUsersWrapper.name,
                  path: 'systemUsers',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      SystemUsersRoute.name,
                      path: '',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i19.RouteConfig(
                      SystemUserFormRoute.name,
                      path: 'form',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i19.RouteConfig(
                      SystemUsersToUploadRoute.name,
                      path: 'for_upload',
                      parent: SystemUsersWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  CustomerWrapper.name,
                  path: 'customer',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      CustomersRoute.name,
                      path: '',
                      parent: CustomerWrapper.name,
                    ),
                    _i19.RouteConfig(
                      CustomerFormRoute.name,
                      path: 'create',
                      parent: CustomerWrapper.name,
                    ),
                    _i19.RouteConfig(
                      CustomersBulkInsertRoute.name,
                      path: 'for_upload',
                      parent: CustomerWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  BranchesWrapper.name,
                  path: 'branches',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      BranchesRoute.name,
                      path: '',
                      parent: BranchesWrapper.name,
                    ),
                    _i19.RouteConfig(
                      BranchCreateRoute.name,
                      path: 'create',
                      parent: BranchesWrapper.name,
                    ),
                    _i19.RouteConfig(
                      BranchEditRoute.name,
                      path: 'edit',
                      parent: BranchesWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  UomsWrapper.name,
                  path: 'uoms',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      UomsRoute.name,
                      path: '',
                      parent: UomsWrapper.name,
                    ),
                    _i19.RouteConfig(
                      UomCreateRoute.name,
                      path: 'create',
                      parent: UomsWrapper.name,
                    ),
                    _i19.RouteConfig(
                      UomEditRoute.name,
                      path: 'edit',
                      parent: UomsWrapper.name,
                    ),
                    _i19.RouteConfig(
                      UomsToUploadRoute.name,
                      path: 'for_upload',
                      parent: UomsWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  ItemGroupWrapper.name,
                  path: 'itemGroup',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      ItemGroupRoute.name,
                      path: '',
                      parent: ItemGroupWrapper.name,
                    ),
                    _i19.RouteConfig(
                      ItemGroupFormRoute.name,
                      path: 'form',
                      parent: ItemGroupWrapper.name,
                    ),
                    _i19.RouteConfig(
                      ItemGroupsToUploadRoute.name,
                      path: 'for_upload',
                      parent: ItemGroupWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  PricelistWrapper.name,
                  path: 'pricelist',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      PricelistRoute.name,
                      path: '',
                      parent: PricelistWrapper.name,
                    ),
                    _i19.RouteConfig(
                      PricelistFormRoute.name,
                      path: 'create',
                      parent: PricelistWrapper.name,
                    ),
                    _i19.RouteConfig(
                      PricelistRowRoute.name,
                      path: 'pricelist_row',
                      parent: PricelistWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  ProductsWrapper.name,
                  path: 'products',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      ProductRoute.name,
                      path: '',
                      parent: ProductsWrapper.name,
                    ),
                    _i19.RouteConfig(
                      ProductFormRoute.name,
                      path: 'form',
                      parent: ProductsWrapper.name,
                    ),
                    _i19.RouteConfig(
                      ProductBulkInsertRoute.name,
                      path: 'for_upload',
                      parent: ProductsWrapper.name,
                    ),
                  ],
                ),
                _i19.RouteConfig(
                  PaymentTermWrapper.name,
                  path: 'payment_terms',
                  parent: MasterDataWrapperRoute.name,
                  children: [
                    _i19.RouteConfig(
                      PaymentTermsRoute.name,
                      path: '',
                      parent: PaymentTermWrapper.name,
                    ),
                    _i19.RouteConfig(
                      PaymentTermFormRoute.name,
                      path: 'form',
                      parent: PaymentTermWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i19.RouteConfig(
              MyProfileRoute.name,
              path: 'my_account',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i19.PageRouteInfo<void> {
  const MainRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i19.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.PurchasingMenuPage]
class PurchasingMenuRoute extends _i19.PageRouteInfo<void> {
  const PurchasingMenuRoute()
      : super(
          PurchasingMenuRoute.name,
          path: 'purchasing',
        );

  static const String name = 'PurchasingMenuRoute';
}

/// generated route for
/// [_i2.SalesMenuWrapperPage]
class SalesMenuWrapperRoute extends _i19.PageRouteInfo<void> {
  const SalesMenuWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SalesMenuWrapperRoute.name,
          path: 'sales',
          initialChildren: children,
        );

  static const String name = 'SalesMenuWrapperRoute';
}

/// generated route for
/// [_i1.InventoryWrapperPage]
class InventoryWrapperRoute extends _i19.PageRouteInfo<void> {
  const InventoryWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          InventoryWrapperRoute.name,
          path: 'inventory',
          initialChildren: children,
        );

  static const String name = 'InventoryWrapperRoute';
}

/// generated route for
/// [_i1.MasterDataWrapperPage]
class MasterDataWrapperRoute extends _i19.PageRouteInfo<void> {
  const MasterDataWrapperRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MasterDataWrapperRoute.name,
          path: 'master_data',
          initialChildren: children,
        );

  static const String name = 'MasterDataWrapperRoute';
}

/// generated route for
/// [_i3.MyProfilePage]
class MyProfileRoute extends _i19.PageRouteInfo<void> {
  const MyProfileRoute()
      : super(
          MyProfileRoute.name,
          path: 'my_account',
        );

  static const String name = 'MyProfileRoute';
}

/// generated route for
/// [_i4.SalesMenuPage]
class SalesMenuRoute extends _i19.PageRouteInfo<void> {
  const SalesMenuRoute()
      : super(
          SalesMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'SalesMenuRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PriceQuotationWrapper extends _i19.PageRouteInfo<void> {
  const PriceQuotationWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          PriceQuotationWrapper.name,
          path: 'sales_order',
          initialChildren: children,
        );

  static const String name = 'PriceQuotationWrapper';
}

/// generated route for
/// [_i6.PriceQuotationPage]
class PriceQuotationRoute extends _i19.PageRouteInfo<void> {
  const PriceQuotationRoute()
      : super(
          PriceQuotationRoute.name,
          path: '',
        );

  static const String name = 'PriceQuotationRoute';
}

/// generated route for
/// [_i7.PriceQuotationHeaderDetailsPage]
class PriceQuotationHeaderDetailsRoute
    extends _i19.PageRouteInfo<PriceQuotationHeaderDetailsRouteArgs> {
  PriceQuotationHeaderDetailsRoute({
    _i22.Key? key,
    required String header,
    required _i23.PriceQuotationModel priceQuotation,
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

  final _i22.Key? key;

  final String header;

  final _i23.PriceQuotationModel priceQuotation;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'PriceQuotationHeaderDetailsRouteArgs{key: $key, header: $header, priceQuotation: $priceQuotation, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.InventoryMenuPage]
class InventoryMenuRoute extends _i19.PageRouteInfo<void> {
  const InventoryMenuRoute()
      : super(
          InventoryMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'InventoryMenuRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class InvAdjInWrapper extends _i19.PageRouteInfo<void> {
  const InvAdjInWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          InvAdjInWrapper.name,
          path: 'inv_adj_in',
          initialChildren: children,
        );

  static const String name = 'InvAdjInWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class InvAdjOutWrapper extends _i19.PageRouteInfo<void> {
  const InvAdjOutWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          InvAdjOutWrapper.name,
          path: 'inv_adj_out',
          initialChildren: children,
        );

  static const String name = 'InvAdjOutWrapper';
}

/// generated route for
/// [_i1.InvAdjustmentInPage]
class InvAdjustmentInRoute extends _i19.PageRouteInfo<void> {
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
    extends _i19.PageRouteInfo<InvAdjustmentInCreateRouteArgs> {
  InvAdjustmentInCreateRoute({
    _i22.Key? key,
    required String header,
    required _i24.InvAdjustmentInBloc invAdjInbloc,
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

  final _i22.Key? key;

  final String header;

  final _i24.InvAdjustmentInBloc invAdjInbloc;

  @override
  String toString() {
    return 'InvAdjustmentInCreateRouteArgs{key: $key, header: $header, invAdjInbloc: $invAdjInbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentInDetailsPage]
class InvAdjustmentInDetailsRoute
    extends _i19.PageRouteInfo<InvAdjustmentInDetailsRouteArgs> {
  InvAdjustmentInDetailsRoute({
    _i22.Key? key,
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

  final _i22.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentInDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutPage]
class InvAdjustmentOutRoute extends _i19.PageRouteInfo<void> {
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
    extends _i19.PageRouteInfo<InvAdjustmentOutCreateRouteArgs> {
  InvAdjustmentOutCreateRoute({
    _i22.Key? key,
    required String header,
    required _i25.InvAdjustmentOutBloc invAdjOutbloc,
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

  final _i22.Key? key;

  final String header;

  final _i25.InvAdjustmentOutBloc invAdjOutbloc;

  @override
  String toString() {
    return 'InvAdjustmentOutCreateRouteArgs{key: $key, header: $header, invAdjOutbloc: $invAdjOutbloc}';
  }
}

/// generated route for
/// [_i1.InvAdjustmentOutDetailsPage]
class InvAdjustmentOutDetailsRoute
    extends _i19.PageRouteInfo<InvAdjustmentOutDetailsRouteArgs> {
  InvAdjustmentOutDetailsRoute({
    _i22.Key? key,
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

  final _i22.Key? key;

  final String header;

  final int id;

  @override
  String toString() {
    return 'InvAdjustmentOutDetailsRouteArgs{key: $key, header: $header, id: $id}';
  }
}

/// generated route for
/// [_i1.MasterDataMenuPage]
class MasterDataMenuRoute extends _i19.PageRouteInfo<void> {
  const MasterDataMenuRoute()
      : super(
          MasterDataMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'MasterDataMenuRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SystemUsersWrapper extends _i19.PageRouteInfo<void> {
  const SystemUsersWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          SystemUsersWrapper.name,
          path: 'systemUsers',
          initialChildren: children,
        );

  static const String name = 'SystemUsersWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CustomerWrapper extends _i19.PageRouteInfo<void> {
  const CustomerWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          CustomerWrapper.name,
          path: 'customer',
          initialChildren: children,
        );

  static const String name = 'CustomerWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class BranchesWrapper extends _i19.PageRouteInfo<void> {
  const BranchesWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          BranchesWrapper.name,
          path: 'branches',
          initialChildren: children,
        );

  static const String name = 'BranchesWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class UomsWrapper extends _i19.PageRouteInfo<void> {
  const UomsWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          UomsWrapper.name,
          path: 'uoms',
          initialChildren: children,
        );

  static const String name = 'UomsWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ItemGroupWrapper extends _i19.PageRouteInfo<void> {
  const ItemGroupWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          ItemGroupWrapper.name,
          path: 'itemGroup',
          initialChildren: children,
        );

  static const String name = 'ItemGroupWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PricelistWrapper extends _i19.PageRouteInfo<void> {
  const PricelistWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          PricelistWrapper.name,
          path: 'pricelist',
          initialChildren: children,
        );

  static const String name = 'PricelistWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProductsWrapper extends _i19.PageRouteInfo<void> {
  const ProductsWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          ProductsWrapper.name,
          path: 'products',
          initialChildren: children,
        );

  static const String name = 'ProductsWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PaymentTermWrapper extends _i19.PageRouteInfo<void> {
  const PaymentTermWrapper({List<_i19.PageRouteInfo>? children})
      : super(
          PaymentTermWrapper.name,
          path: 'payment_terms',
          initialChildren: children,
        );

  static const String name = 'PaymentTermWrapper';
}

/// generated route for
/// [_i1.SystemUsersPage]
class SystemUsersRoute extends _i19.PageRouteInfo<void> {
  const SystemUsersRoute()
      : super(
          SystemUsersRoute.name,
          path: '',
        );

  static const String name = 'SystemUsersRoute';
}

/// generated route for
/// [_i1.SystemUserFormPage]
class SystemUserFormRoute extends _i19.PageRouteInfo<SystemUserFormRouteArgs> {
  SystemUserFormRoute({
    _i22.Key? key,
    _i23.SystemUserModel? selectedSystemUser,
    required void Function() onRefresh,
  }) : super(
          SystemUserFormRoute.name,
          path: 'form',
          args: SystemUserFormRouteArgs(
            key: key,
            selectedSystemUser: selectedSystemUser,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'SystemUserFormRoute';
}

class SystemUserFormRouteArgs {
  const SystemUserFormRouteArgs({
    this.key,
    this.selectedSystemUser,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final _i23.SystemUserModel? selectedSystemUser;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'SystemUserFormRouteArgs{key: $key, selectedSystemUser: $selectedSystemUser, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i8.SystemUsersToUploadPage]
class SystemUsersToUploadRoute
    extends _i19.PageRouteInfo<SystemUsersToUploadRouteArgs> {
  SystemUsersToUploadRoute({
    _i22.Key? key,
    required List<_i23.CreateSystemUserModel> datas,
    required void Function() onRefresh,
  }) : super(
          SystemUsersToUploadRoute.name,
          path: 'for_upload',
          args: SystemUsersToUploadRouteArgs(
            key: key,
            datas: datas,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'SystemUsersToUploadRoute';
}

class SystemUsersToUploadRouteArgs {
  const SystemUsersToUploadRouteArgs({
    this.key,
    required this.datas,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final List<_i23.CreateSystemUserModel> datas;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'SystemUsersToUploadRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i9.CustomersPage]
class CustomersRoute extends _i19.PageRouteInfo<void> {
  const CustomersRoute()
      : super(
          CustomersRoute.name,
          path: '',
        );

  static const String name = 'CustomersRoute';
}

/// generated route for
/// [_i10.CustomerFormPage]
class CustomerFormRoute extends _i19.PageRouteInfo<CustomerFormRouteArgs> {
  CustomerFormRoute({
    _i22.Key? key,
    required String header,
    _i23.CustomerModel? selectedCustomer,
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

  final _i22.Key? key;

  final String header;

  final _i23.CustomerModel? selectedCustomer;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'CustomerFormRouteArgs{key: $key, header: $header, selectedCustomer: $selectedCustomer, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i11.CustomersBulkInsertPage]
class CustomersBulkInsertRoute
    extends _i19.PageRouteInfo<CustomersBulkInsertRouteArgs> {
  CustomersBulkInsertRoute({
    _i22.Key? key,
    required List<_i23.CustomerCreateModel> datas,
    required void Function() onRefresh,
  }) : super(
          CustomersBulkInsertRoute.name,
          path: 'for_upload',
          args: CustomersBulkInsertRouteArgs(
            key: key,
            datas: datas,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'CustomersBulkInsertRoute';
}

class CustomersBulkInsertRouteArgs {
  const CustomersBulkInsertRouteArgs({
    this.key,
    required this.datas,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final List<_i23.CustomerCreateModel> datas;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'CustomersBulkInsertRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.BranchesPage]
class BranchesRoute extends _i19.PageRouteInfo<void> {
  const BranchesRoute()
      : super(
          BranchesRoute.name,
          path: '',
        );

  static const String name = 'BranchesRoute';
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchCreateRoute extends _i19.PageRouteInfo<BranchCreateRouteArgs> {
  BranchCreateRoute({
    _i22.Key? key,
    required String header,
    _i23.BranchModel? selectedBranch,
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

  final _i22.Key? key;

  final String header;

  final _i23.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchCreateRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchEditRoute extends _i19.PageRouteInfo<BranchEditRouteArgs> {
  BranchEditRoute({
    _i22.Key? key,
    required String header,
    _i23.BranchModel? selectedBranch,
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

  final _i22.Key? key;

  final String header;

  final _i23.BranchModel? selectedBranch;

  @override
  String toString() {
    return 'BranchEditRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch}';
  }
}

/// generated route for
/// [_i1.UomsPage]
class UomsRoute extends _i19.PageRouteInfo<void> {
  const UomsRoute()
      : super(
          UomsRoute.name,
          path: '',
        );

  static const String name = 'UomsRoute';
}

/// generated route for
/// [_i1.UomFormPage]
class UomCreateRoute extends _i19.PageRouteInfo<UomCreateRouteArgs> {
  UomCreateRoute({
    _i22.Key? key,
    required String header,
    _i23.UomModel? selectedUom,
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

  final _i22.Key? key;

  final String header;

  final _i23.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomCreateRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i1.UomFormPage]
class UomEditRoute extends _i19.PageRouteInfo<UomEditRouteArgs> {
  UomEditRoute({
    _i22.Key? key,
    required String header,
    _i23.UomModel? selectedUom,
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

  final _i22.Key? key;

  final String header;

  final _i23.UomModel? selectedUom;

  @override
  String toString() {
    return 'UomEditRouteArgs{key: $key, header: $header, selectedUom: $selectedUom}';
  }
}

/// generated route for
/// [_i12.UomsToUploadPage]
class UomsToUploadRoute extends _i19.PageRouteInfo<UomsToUploadRouteArgs> {
  UomsToUploadRoute({
    _i22.Key? key,
    required List<_i23.UomModel> uoms,
    required void Function() onRefresh,
  }) : super(
          UomsToUploadRoute.name,
          path: 'for_upload',
          args: UomsToUploadRouteArgs(
            key: key,
            uoms: uoms,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'UomsToUploadRoute';
}

class UomsToUploadRouteArgs {
  const UomsToUploadRouteArgs({
    this.key,
    required this.uoms,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final List<_i23.UomModel> uoms;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'UomsToUploadRouteArgs{key: $key, uoms: $uoms, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i13.ItemGroupPage]
class ItemGroupRoute extends _i19.PageRouteInfo<void> {
  const ItemGroupRoute()
      : super(
          ItemGroupRoute.name,
          path: '',
        );

  static const String name = 'ItemGroupRoute';
}

/// generated route for
/// [_i14.ItemGroupFormPage]
class ItemGroupFormRoute extends _i19.PageRouteInfo<ItemGroupFormRouteArgs> {
  ItemGroupFormRoute({
    _i22.Key? key,
    required String header,
    _i23.ItemGroupModel? selectedItemGroup,
  }) : super(
          ItemGroupFormRoute.name,
          path: 'form',
          args: ItemGroupFormRouteArgs(
            key: key,
            header: header,
            selectedItemGroup: selectedItemGroup,
          ),
        );

  static const String name = 'ItemGroupFormRoute';
}

class ItemGroupFormRouteArgs {
  const ItemGroupFormRouteArgs({
    this.key,
    required this.header,
    this.selectedItemGroup,
  });

  final _i22.Key? key;

  final String header;

  final _i23.ItemGroupModel? selectedItemGroup;

  @override
  String toString() {
    return 'ItemGroupFormRouteArgs{key: $key, header: $header, selectedItemGroup: $selectedItemGroup}';
  }
}

/// generated route for
/// [_i15.ItemGroupsToUploadPage]
class ItemGroupsToUploadRoute
    extends _i19.PageRouteInfo<ItemGroupsToUploadRouteArgs> {
  ItemGroupsToUploadRoute({
    _i22.Key? key,
    required List<_i23.ItemGroupModel> datas,
    required void Function() onRefresh,
  }) : super(
          ItemGroupsToUploadRoute.name,
          path: 'for_upload',
          args: ItemGroupsToUploadRouteArgs(
            key: key,
            datas: datas,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'ItemGroupsToUploadRoute';
}

class ItemGroupsToUploadRouteArgs {
  const ItemGroupsToUploadRouteArgs({
    this.key,
    required this.datas,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final List<_i23.ItemGroupModel> datas;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'ItemGroupsToUploadRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.PricelistPage]
class PricelistRoute extends _i19.PageRouteInfo<void> {
  const PricelistRoute()
      : super(
          PricelistRoute.name,
          path: '',
        );

  static const String name = 'PricelistRoute';
}

/// generated route for
/// [_i1.PricelistFormPage]
class PricelistFormRoute extends _i19.PageRouteInfo<PricelistFormRouteArgs> {
  PricelistFormRoute({
    _i22.Key? key,
    required String header,
    _i23.PricelistModel? selectedPricelist,
    required _i26.Future<void> Function() refresh,
  }) : super(
          PricelistFormRoute.name,
          path: 'create',
          args: PricelistFormRouteArgs(
            key: key,
            header: header,
            selectedPricelist: selectedPricelist,
            refresh: refresh,
          ),
        );

  static const String name = 'PricelistFormRoute';
}

class PricelistFormRouteArgs {
  const PricelistFormRouteArgs({
    this.key,
    required this.header,
    this.selectedPricelist,
    required this.refresh,
  });

  final _i22.Key? key;

  final String header;

  final _i23.PricelistModel? selectedPricelist;

  final _i26.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistFormRouteArgs{key: $key, header: $header, selectedPricelist: $selectedPricelist, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.PricelistRowPage]
class PricelistRowRoute extends _i19.PageRouteInfo<PricelistRowRouteArgs> {
  PricelistRowRoute({
    _i22.Key? key,
    String? pricelistCode,
    String? itemCode,
    required _i26.Future<void> Function() refresh,
  }) : super(
          PricelistRowRoute.name,
          path: 'pricelist_row',
          args: PricelistRowRouteArgs(
            key: key,
            pricelistCode: pricelistCode,
            itemCode: itemCode,
            refresh: refresh,
          ),
        );

  static const String name = 'PricelistRowRoute';
}

class PricelistRowRouteArgs {
  const PricelistRowRouteArgs({
    this.key,
    this.pricelistCode,
    this.itemCode,
    required this.refresh,
  });

  final _i22.Key? key;

  final String? pricelistCode;

  final String? itemCode;

  final _i26.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistRowRouteArgs{key: $key, pricelistCode: $pricelistCode, itemCode: $itemCode, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.ProductPage]
class ProductRoute extends _i19.PageRouteInfo<void> {
  const ProductRoute()
      : super(
          ProductRoute.name,
          path: '',
        );

  static const String name = 'ProductRoute';
}

/// generated route for
/// [_i1.ProductFormPage]
class ProductFormRoute extends _i19.PageRouteInfo<ProductFormRouteArgs> {
  ProductFormRoute({
    _i22.Key? key,
    required String header,
    _i23.ProductModel? selectedItem,
  }) : super(
          ProductFormRoute.name,
          path: 'form',
          args: ProductFormRouteArgs(
            key: key,
            header: header,
            selectedItem: selectedItem,
          ),
        );

  static const String name = 'ProductFormRoute';
}

class ProductFormRouteArgs {
  const ProductFormRouteArgs({
    this.key,
    required this.header,
    this.selectedItem,
  });

  final _i22.Key? key;

  final String header;

  final _i23.ProductModel? selectedItem;

  @override
  String toString() {
    return 'ProductFormRouteArgs{key: $key, header: $header, selectedItem: $selectedItem}';
  }
}

/// generated route for
/// [_i16.ProductBulkInsertPage]
class ProductBulkInsertRoute
    extends _i19.PageRouteInfo<ProductBulkInsertRouteArgs> {
  ProductBulkInsertRoute({
    _i22.Key? key,
    required List<_i23.CreateProductModel> datas,
    required void Function() onRefresh,
  }) : super(
          ProductBulkInsertRoute.name,
          path: 'for_upload',
          args: ProductBulkInsertRouteArgs(
            key: key,
            datas: datas,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'ProductBulkInsertRoute';
}

class ProductBulkInsertRouteArgs {
  const ProductBulkInsertRouteArgs({
    this.key,
    required this.datas,
    required this.onRefresh,
  });

  final _i22.Key? key;

  final List<_i23.CreateProductModel> datas;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'ProductBulkInsertRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i17.PaymentTermsPage]
class PaymentTermsRoute extends _i19.PageRouteInfo<void> {
  const PaymentTermsRoute()
      : super(
          PaymentTermsRoute.name,
          path: '',
        );

  static const String name = 'PaymentTermsRoute';
}

/// generated route for
/// [_i18.PaymentTermFormPage]
class PaymentTermFormRoute
    extends _i19.PageRouteInfo<PaymentTermFormRouteArgs> {
  PaymentTermFormRoute({
    _i22.Key? key,
    required String header,
    _i23.PaymentTermModel? selectedPayTermObj,
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

  final _i22.Key? key;

  final String header;

  final _i23.PaymentTermModel? selectedPayTermObj;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'PaymentTermFormRouteArgs{key: $key, header: $header, selectedPayTermObj: $selectedPayTermObj, onRefresh: $onRefresh}';
  }
}
