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

import 'package:auto_route/auto_route.dart' as _i22;
import 'package:auto_route/empty_router_widgets.dart' as _i5;
import 'package:fluent_ui/fluent_ui.dart' as _i24;
import 'package:flutter/material.dart' as _i23;
import 'package:jpsc_windows_app/src/data/models/models.dart' as _i25;
import 'package:jpsc_windows_app/src/pages/exports.dart' as _i1;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/app_versions/appversions.dart'
    as _i17;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/app_versions/components/version_form.dart'
    as _i18;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/components/form/customer_form.dart'
    as _i8;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/components/upload_page.dart'
    as _i9;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/customers/customers.dart'
    as _i7;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/components/upload_page.dart'
    as _i13;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/form/form.dart'
    as _i12;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/item_group/item_group.dart'
    as _i11;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/payment_terms/components/form.dart'
    as _i16;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/payment_terms/payment_terms.dart'
    as _i15;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/products/widgets/upload_page.dart'
    as _i14;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/system_users/components/upload_page.dart'
    as _i6;
import 'package:jpsc_windows_app/src/pages/menu_master_data/menus/uoms/widgets/uoms_to_upload.dart'
    as _i10;
import 'package:jpsc_windows_app/src/pages/menu_profile/my_profile_page.dart'
    as _i4;
import 'package:jpsc_windows_app/src/pages/menu_sales/main_wrapper.dart' as _i3;
import 'package:jpsc_windows_app/src/pages/menu_sales/modules/price_quotation/components/details/pq_details.dart'
    as _i21;
import 'package:jpsc_windows_app/src/pages/menu_sales/modules/price_quotation/price_quotation.dart'
    as _i20;
import 'package:jpsc_windows_app/src/pages/menu_sales/sales_menu.dart' as _i19;
import 'package:jpsc_windows_app/src/pages/unknown_page.dart' as _i2;

class AppRouter extends _i22.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UnknownRouteRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.UnknownRoutePage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardPage.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MasterDataMainWrapperPage.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataMainWrapper(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMainWrapperPage.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.SalesMainWrapper(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyProfilePage.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.MyProfile(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MasterDataMenuRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.MasterDataMenuPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductsWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppVersionsWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SystemUsersPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUserFormRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUserFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.SystemUserFormPage(
          key: args.key,
          selectedSystemUser: args.selectedSystemUser,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SystemUsersToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<SystemUsersToUploadRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.SystemUsersToUploadPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.CustomersPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomerFormRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.CustomerFormPage(
          key: args.key,
          header: args.header,
          selectedCustomer: args.selectedCustomer,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CustomersBulkInsertRoute.name: (routeData) {
      final args = routeData.argsAs<CustomersBulkInsertRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.CustomersBulkInsertPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchesRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.BranchesPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchCreateRoute.name: (routeData) {
      final args = routeData.argsAs<BranchCreateRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    BranchEditRoute.name: (routeData) {
      final args = routeData.argsAs<BranchEditRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.BranchFormPage(
          key: args.key,
          header: args.header,
          selectedBranch: args.selectedBranch,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.UomsPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomCreateRoute.name: (routeData) {
      final args = routeData.argsAs<UomCreateRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomEditRoute.name: (routeData) {
      final args = routeData.argsAs<UomEditRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.UomFormPage(
          key: args.key,
          header: args.header,
          selectedUom: args.selectedUom,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    UomsToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<UomsToUploadRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.UomsToUploadPage(
          key: args.key,
          uoms: args.uoms,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i11.ItemGroupPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupFormRoute.name: (routeData) {
      final args = routeData.argsAs<ItemGroupFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.ItemGroupFormPage(
          key: args.key,
          header: args.header,
          selectedItemGroup: args.selectedItemGroup,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ItemGroupsToUploadRoute.name: (routeData) {
      final args = routeData.argsAs<ItemGroupsToUploadRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.ItemGroupsToUploadPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.PricelistPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistFormRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistFormPage(
          key: args.key,
          header: args.header,
          selectedPricelist: args.selectedPricelist,
          refresh: args.refresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PricelistRowRoute.name: (routeData) {
      final args = routeData.argsAs<PricelistRowRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.PricelistRowPage(
          key: args.key,
          pricelistCode: args.pricelistCode,
          itemCode: args.itemCode,
          refresh: args.refresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProductPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductFormRoute.name: (routeData) {
      final args = routeData.argsAs<ProductFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ProductFormPage(
          key: args.key,
          header: args.header,
          selectedItem: args.selectedItem,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductBulkInsertRoute.name: (routeData) {
      final args = routeData.argsAs<ProductBulkInsertRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.ProductBulkInsertPage(
          key: args.key,
          datas: args.datas,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermsRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i15.PaymentTermsPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PaymentTermFormRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentTermFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i16.PaymentTermFormPage(
          key: args.key,
          header: args.header,
          selectedPayTermObj: args.selectedPayTermObj,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppVersionRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i17.AppVersionPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AppVersionFormRoute.name: (routeData) {
      final args = routeData.argsAs<AppVersionFormRouteArgs>();
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i18.AppVersionFormPage(
          key: args.key,
          header: args.header,
          onRefresh: args.onRefresh,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SalesMenuRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i19.SalesMenuPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationWrapper.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.EmptyRouterPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationRoute.name: (routeData) {
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i20.PriceQuotationPage(),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PriceQuotationHeaderDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<PriceQuotationHeaderDetailsRouteArgs>(
          orElse: () => PriceQuotationHeaderDetailsRouteArgs(
                id: pathParams.getInt('id'),
                header: queryParams.getString(
                  'header',
                  "",
                ),
              ));
      return _i22.CustomPage<dynamic>(
        routeData: routeData,
        child: _i21.PriceQuotationHeaderDetailsPage(
          key: args.key,
          id: args.id,
          header: args.header,
        ),
        transitionsBuilder: _i22.TransitionsBuilders.noTransition,
        durationInMilliseconds: 5,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i22.RouteConfig> get routes => [
        _i22.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i22.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i22.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i22.RouteConfig(
              DashboardPage.name,
              path: 'dashboard',
              parent: MainRoute.name,
            ),
            _i22.RouteConfig(
              MasterDataMainWrapperPage.name,
              path: 'master_data',
              parent: MainRoute.name,
              children: [
                _i22.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MasterDataMainWrapperPage.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i22.RouteConfig(
                  MasterDataMenuRoute.name,
                  path: 'menu',
                  parent: MasterDataMainWrapperPage.name,
                ),
                _i22.RouteConfig(
                  SystemUsersWrapper.name,
                  path: 'systemUsers',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      SystemUsersRoute.name,
                      path: '',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i22.RouteConfig(
                      SystemUserFormRoute.name,
                      path: 'form',
                      parent: SystemUsersWrapper.name,
                    ),
                    _i22.RouteConfig(
                      SystemUsersToUploadRoute.name,
                      path: 'for_upload',
                      parent: SystemUsersWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  CustomerWrapper.name,
                  path: 'customer',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      CustomersRoute.name,
                      path: '',
                      parent: CustomerWrapper.name,
                    ),
                    _i22.RouteConfig(
                      CustomerFormRoute.name,
                      path: 'create',
                      parent: CustomerWrapper.name,
                    ),
                    _i22.RouteConfig(
                      CustomersBulkInsertRoute.name,
                      path: 'for_upload',
                      parent: CustomerWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  BranchesWrapper.name,
                  path: 'branches',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      BranchesRoute.name,
                      path: '',
                      parent: BranchesWrapper.name,
                    ),
                    _i22.RouteConfig(
                      BranchCreateRoute.name,
                      path: 'create',
                      parent: BranchesWrapper.name,
                    ),
                    _i22.RouteConfig(
                      BranchEditRoute.name,
                      path: 'edit',
                      parent: BranchesWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  UomsWrapper.name,
                  path: 'uoms',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      UomsRoute.name,
                      path: '',
                      parent: UomsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      UomCreateRoute.name,
                      path: 'create',
                      parent: UomsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      UomEditRoute.name,
                      path: 'edit',
                      parent: UomsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      UomsToUploadRoute.name,
                      path: 'for_upload',
                      parent: UomsWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  ItemGroupWrapper.name,
                  path: 'itemGroup',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      ItemGroupRoute.name,
                      path: '',
                      parent: ItemGroupWrapper.name,
                    ),
                    _i22.RouteConfig(
                      ItemGroupFormRoute.name,
                      path: 'form',
                      parent: ItemGroupWrapper.name,
                    ),
                    _i22.RouteConfig(
                      ItemGroupsToUploadRoute.name,
                      path: 'for_upload',
                      parent: ItemGroupWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  PricelistWrapper.name,
                  path: 'pricelist',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      PricelistRoute.name,
                      path: '',
                      parent: PricelistWrapper.name,
                    ),
                    _i22.RouteConfig(
                      PricelistFormRoute.name,
                      path: 'create',
                      parent: PricelistWrapper.name,
                    ),
                    _i22.RouteConfig(
                      PricelistRowRoute.name,
                      path: 'pricelist_row',
                      parent: PricelistWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  ProductsWrapper.name,
                  path: 'products',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      ProductRoute.name,
                      path: '',
                      parent: ProductsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      ProductFormRoute.name,
                      path: 'form',
                      parent: ProductsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      ProductBulkInsertRoute.name,
                      path: 'for_upload',
                      parent: ProductsWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  PaymentTermWrapper.name,
                  path: 'payment_terms',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      PaymentTermsRoute.name,
                      path: '',
                      parent: PaymentTermWrapper.name,
                    ),
                    _i22.RouteConfig(
                      PaymentTermFormRoute.name,
                      path: 'form',
                      parent: PaymentTermWrapper.name,
                    ),
                  ],
                ),
                _i22.RouteConfig(
                  AppVersionsWrapper.name,
                  path: 'app_versions',
                  parent: MasterDataMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      AppVersionRoute.name,
                      path: '',
                      parent: AppVersionsWrapper.name,
                    ),
                    _i22.RouteConfig(
                      AppVersionFormRoute.name,
                      path: 'form',
                      parent: AppVersionsWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i22.RouteConfig(
              SalesMainWrapperPage.name,
              path: 'sales',
              parent: MainRoute.name,
              children: [
                _i22.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: SalesMainWrapperPage.name,
                  redirectTo: 'menu',
                  fullMatch: true,
                ),
                _i22.RouteConfig(
                  SalesMenuRoute.name,
                  path: 'menu',
                  parent: SalesMainWrapperPage.name,
                ),
                _i22.RouteConfig(
                  PriceQuotationWrapper.name,
                  path: 'price_quotation/',
                  parent: SalesMainWrapperPage.name,
                  children: [
                    _i22.RouteConfig(
                      PriceQuotationRoute.name,
                      path: '',
                      parent: PriceQuotationWrapper.name,
                    ),
                    _i22.RouteConfig(
                      PriceQuotationHeaderDetailsRoute.name,
                      path: ':id',
                      parent: PriceQuotationWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
            _i22.RouteConfig(
              MyProfilePage.name,
              path: 'my_account',
              parent: MainRoute.name,
            ),
          ],
        ),
        _i22.RouteConfig(
          UnknownRouteRoute.name,
          path: '*',
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i22.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i22.PageRouteInfo<void> {
  const MainRoute({List<_i22.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.UnknownRoutePage]
class UnknownRouteRoute extends _i22.PageRouteInfo<void> {
  const UnknownRouteRoute()
      : super(
          UnknownRouteRoute.name,
          path: '*',
        );

  static const String name = 'UnknownRouteRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardPage extends _i22.PageRouteInfo<void> {
  const DashboardPage()
      : super(
          DashboardPage.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardPage';
}

/// generated route for
/// [_i1.MasterDataMainWrapper]
class MasterDataMainWrapperPage extends _i22.PageRouteInfo<void> {
  const MasterDataMainWrapperPage({List<_i22.PageRouteInfo>? children})
      : super(
          MasterDataMainWrapperPage.name,
          path: 'master_data',
          initialChildren: children,
        );

  static const String name = 'MasterDataMainWrapperPage';
}

/// generated route for
/// [_i3.SalesMainWrapper]
class SalesMainWrapperPage extends _i22.PageRouteInfo<void> {
  const SalesMainWrapperPage({List<_i22.PageRouteInfo>? children})
      : super(
          SalesMainWrapperPage.name,
          path: 'sales',
          initialChildren: children,
        );

  static const String name = 'SalesMainWrapperPage';
}

/// generated route for
/// [_i4.MyProfile]
class MyProfilePage extends _i22.PageRouteInfo<void> {
  const MyProfilePage()
      : super(
          MyProfilePage.name,
          path: 'my_account',
        );

  static const String name = 'MyProfilePage';
}

/// generated route for
/// [_i1.MasterDataMenuPage]
class MasterDataMenuRoute extends _i22.PageRouteInfo<void> {
  const MasterDataMenuRoute()
      : super(
          MasterDataMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'MasterDataMenuRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SystemUsersWrapper extends _i22.PageRouteInfo<void> {
  const SystemUsersWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          SystemUsersWrapper.name,
          path: 'systemUsers',
          initialChildren: children,
        );

  static const String name = 'SystemUsersWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CustomerWrapper extends _i22.PageRouteInfo<void> {
  const CustomerWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          CustomerWrapper.name,
          path: 'customer',
          initialChildren: children,
        );

  static const String name = 'CustomerWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class BranchesWrapper extends _i22.PageRouteInfo<void> {
  const BranchesWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          BranchesWrapper.name,
          path: 'branches',
          initialChildren: children,
        );

  static const String name = 'BranchesWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class UomsWrapper extends _i22.PageRouteInfo<void> {
  const UomsWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          UomsWrapper.name,
          path: 'uoms',
          initialChildren: children,
        );

  static const String name = 'UomsWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ItemGroupWrapper extends _i22.PageRouteInfo<void> {
  const ItemGroupWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          ItemGroupWrapper.name,
          path: 'itemGroup',
          initialChildren: children,
        );

  static const String name = 'ItemGroupWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PricelistWrapper extends _i22.PageRouteInfo<void> {
  const PricelistWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          PricelistWrapper.name,
          path: 'pricelist',
          initialChildren: children,
        );

  static const String name = 'PricelistWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProductsWrapper extends _i22.PageRouteInfo<void> {
  const ProductsWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          ProductsWrapper.name,
          path: 'products',
          initialChildren: children,
        );

  static const String name = 'ProductsWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PaymentTermWrapper extends _i22.PageRouteInfo<void> {
  const PaymentTermWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          PaymentTermWrapper.name,
          path: 'payment_terms',
          initialChildren: children,
        );

  static const String name = 'PaymentTermWrapper';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class AppVersionsWrapper extends _i22.PageRouteInfo<void> {
  const AppVersionsWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          AppVersionsWrapper.name,
          path: 'app_versions',
          initialChildren: children,
        );

  static const String name = 'AppVersionsWrapper';
}

/// generated route for
/// [_i1.SystemUsersPage]
class SystemUsersRoute extends _i22.PageRouteInfo<void> {
  const SystemUsersRoute()
      : super(
          SystemUsersRoute.name,
          path: '',
        );

  static const String name = 'SystemUsersRoute';
}

/// generated route for
/// [_i1.SystemUserFormPage]
class SystemUserFormRoute extends _i22.PageRouteInfo<SystemUserFormRouteArgs> {
  SystemUserFormRoute({
    _i24.Key? key,
    _i25.SystemUserModel? selectedSystemUser,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final _i25.SystemUserModel? selectedSystemUser;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'SystemUserFormRouteArgs{key: $key, selectedSystemUser: $selectedSystemUser, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i6.SystemUsersToUploadPage]
class SystemUsersToUploadRoute
    extends _i22.PageRouteInfo<SystemUsersToUploadRouteArgs> {
  SystemUsersToUploadRoute({
    _i24.Key? key,
    required List<_i25.CreateSystemUserModel> datas,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final List<_i25.CreateSystemUserModel> datas;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'SystemUsersToUploadRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i7.CustomersPage]
class CustomersRoute extends _i22.PageRouteInfo<void> {
  const CustomersRoute()
      : super(
          CustomersRoute.name,
          path: '',
        );

  static const String name = 'CustomersRoute';
}

/// generated route for
/// [_i8.CustomerFormPage]
class CustomerFormRoute extends _i22.PageRouteInfo<CustomerFormRouteArgs> {
  CustomerFormRoute({
    _i24.Key? key,
    required String header,
    _i25.CustomerModel? selectedCustomer,
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

  final _i24.Key? key;

  final String header;

  final _i25.CustomerModel? selectedCustomer;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'CustomerFormRouteArgs{key: $key, header: $header, selectedCustomer: $selectedCustomer, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i9.CustomersBulkInsertPage]
class CustomersBulkInsertRoute
    extends _i22.PageRouteInfo<CustomersBulkInsertRouteArgs> {
  CustomersBulkInsertRoute({
    _i24.Key? key,
    required List<_i25.CustomerCreateModel> datas,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final List<_i25.CustomerCreateModel> datas;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'CustomersBulkInsertRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.BranchesPage]
class BranchesRoute extends _i22.PageRouteInfo<void> {
  const BranchesRoute()
      : super(
          BranchesRoute.name,
          path: '',
        );

  static const String name = 'BranchesRoute';
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchCreateRoute extends _i22.PageRouteInfo<BranchCreateRouteArgs> {
  BranchCreateRoute({
    _i24.Key? key,
    required String header,
    _i25.BranchModel? selectedBranch,
    required dynamic onRefresh,
  }) : super(
          BranchCreateRoute.name,
          path: 'create',
          args: BranchCreateRouteArgs(
            key: key,
            header: header,
            selectedBranch: selectedBranch,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'BranchCreateRoute';
}

class BranchCreateRouteArgs {
  const BranchCreateRouteArgs({
    this.key,
    required this.header,
    this.selectedBranch,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final _i25.BranchModel? selectedBranch;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'BranchCreateRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.BranchFormPage]
class BranchEditRoute extends _i22.PageRouteInfo<BranchEditRouteArgs> {
  BranchEditRoute({
    _i24.Key? key,
    required String header,
    _i25.BranchModel? selectedBranch,
    required dynamic onRefresh,
  }) : super(
          BranchEditRoute.name,
          path: 'edit',
          args: BranchEditRouteArgs(
            key: key,
            header: header,
            selectedBranch: selectedBranch,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'BranchEditRoute';
}

class BranchEditRouteArgs {
  const BranchEditRouteArgs({
    this.key,
    required this.header,
    this.selectedBranch,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final _i25.BranchModel? selectedBranch;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'BranchEditRouteArgs{key: $key, header: $header, selectedBranch: $selectedBranch, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.UomsPage]
class UomsRoute extends _i22.PageRouteInfo<void> {
  const UomsRoute()
      : super(
          UomsRoute.name,
          path: '',
        );

  static const String name = 'UomsRoute';
}

/// generated route for
/// [_i1.UomFormPage]
class UomCreateRoute extends _i22.PageRouteInfo<UomCreateRouteArgs> {
  UomCreateRoute({
    _i24.Key? key,
    required String header,
    _i25.UomModel? selectedUom,
    required dynamic onRefresh,
  }) : super(
          UomCreateRoute.name,
          path: 'create',
          args: UomCreateRouteArgs(
            key: key,
            header: header,
            selectedUom: selectedUom,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'UomCreateRoute';
}

class UomCreateRouteArgs {
  const UomCreateRouteArgs({
    this.key,
    required this.header,
    this.selectedUom,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final _i25.UomModel? selectedUom;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'UomCreateRouteArgs{key: $key, header: $header, selectedUom: $selectedUom, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.UomFormPage]
class UomEditRoute extends _i22.PageRouteInfo<UomEditRouteArgs> {
  UomEditRoute({
    _i24.Key? key,
    required String header,
    _i25.UomModel? selectedUom,
    required dynamic onRefresh,
  }) : super(
          UomEditRoute.name,
          path: 'edit',
          args: UomEditRouteArgs(
            key: key,
            header: header,
            selectedUom: selectedUom,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'UomEditRoute';
}

class UomEditRouteArgs {
  const UomEditRouteArgs({
    this.key,
    required this.header,
    this.selectedUom,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final _i25.UomModel? selectedUom;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'UomEditRouteArgs{key: $key, header: $header, selectedUom: $selectedUom, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i10.UomsToUploadPage]
class UomsToUploadRoute extends _i22.PageRouteInfo<UomsToUploadRouteArgs> {
  UomsToUploadRoute({
    _i24.Key? key,
    required List<_i25.UomModel> uoms,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final List<_i25.UomModel> uoms;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'UomsToUploadRouteArgs{key: $key, uoms: $uoms, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i11.ItemGroupPage]
class ItemGroupRoute extends _i22.PageRouteInfo<void> {
  const ItemGroupRoute()
      : super(
          ItemGroupRoute.name,
          path: '',
        );

  static const String name = 'ItemGroupRoute';
}

/// generated route for
/// [_i12.ItemGroupFormPage]
class ItemGroupFormRoute extends _i22.PageRouteInfo<ItemGroupFormRouteArgs> {
  ItemGroupFormRoute({
    _i24.Key? key,
    required String header,
    _i25.ItemGroupModel? selectedItemGroup,
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

  final _i24.Key? key;

  final String header;

  final _i25.ItemGroupModel? selectedItemGroup;

  @override
  String toString() {
    return 'ItemGroupFormRouteArgs{key: $key, header: $header, selectedItemGroup: $selectedItemGroup}';
  }
}

/// generated route for
/// [_i13.ItemGroupsToUploadPage]
class ItemGroupsToUploadRoute
    extends _i22.PageRouteInfo<ItemGroupsToUploadRouteArgs> {
  ItemGroupsToUploadRoute({
    _i24.Key? key,
    required List<_i25.ItemGroupModel> datas,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final List<_i25.ItemGroupModel> datas;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'ItemGroupsToUploadRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i1.PricelistPage]
class PricelistRoute extends _i22.PageRouteInfo<void> {
  const PricelistRoute()
      : super(
          PricelistRoute.name,
          path: '',
        );

  static const String name = 'PricelistRoute';
}

/// generated route for
/// [_i1.PricelistFormPage]
class PricelistFormRoute extends _i22.PageRouteInfo<PricelistFormRouteArgs> {
  PricelistFormRoute({
    _i24.Key? key,
    required String header,
    _i25.PricelistModel? selectedPricelist,
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

  final _i24.Key? key;

  final String header;

  final _i25.PricelistModel? selectedPricelist;

  final _i26.Future<void> Function() refresh;

  @override
  String toString() {
    return 'PricelistFormRouteArgs{key: $key, header: $header, selectedPricelist: $selectedPricelist, refresh: $refresh}';
  }
}

/// generated route for
/// [_i1.PricelistRowPage]
class PricelistRowRoute extends _i22.PageRouteInfo<PricelistRowRouteArgs> {
  PricelistRowRoute({
    _i24.Key? key,
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

  final _i24.Key? key;

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
class ProductRoute extends _i22.PageRouteInfo<void> {
  const ProductRoute()
      : super(
          ProductRoute.name,
          path: '',
        );

  static const String name = 'ProductRoute';
}

/// generated route for
/// [_i1.ProductFormPage]
class ProductFormRoute extends _i22.PageRouteInfo<ProductFormRouteArgs> {
  ProductFormRoute({
    _i24.Key? key,
    required String header,
    _i25.ProductModel? selectedItem,
    required dynamic onRefresh,
  }) : super(
          ProductFormRoute.name,
          path: 'form',
          args: ProductFormRouteArgs(
            key: key,
            header: header,
            selectedItem: selectedItem,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'ProductFormRoute';
}

class ProductFormRouteArgs {
  const ProductFormRouteArgs({
    this.key,
    required this.header,
    this.selectedItem,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final _i25.ProductModel? selectedItem;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'ProductFormRouteArgs{key: $key, header: $header, selectedItem: $selectedItem, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i14.ProductBulkInsertPage]
class ProductBulkInsertRoute
    extends _i22.PageRouteInfo<ProductBulkInsertRouteArgs> {
  ProductBulkInsertRoute({
    _i24.Key? key,
    required List<_i25.CreateProductModel> datas,
    required dynamic onRefresh,
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

  final _i24.Key? key;

  final List<_i25.CreateProductModel> datas;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'ProductBulkInsertRouteArgs{key: $key, datas: $datas, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i15.PaymentTermsPage]
class PaymentTermsRoute extends _i22.PageRouteInfo<void> {
  const PaymentTermsRoute()
      : super(
          PaymentTermsRoute.name,
          path: '',
        );

  static const String name = 'PaymentTermsRoute';
}

/// generated route for
/// [_i16.PaymentTermFormPage]
class PaymentTermFormRoute
    extends _i22.PageRouteInfo<PaymentTermFormRouteArgs> {
  PaymentTermFormRoute({
    _i24.Key? key,
    required String header,
    _i25.PaymentTermModel? selectedPayTermObj,
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

  final _i24.Key? key;

  final String header;

  final _i25.PaymentTermModel? selectedPayTermObj;

  final void Function() onRefresh;

  @override
  String toString() {
    return 'PaymentTermFormRouteArgs{key: $key, header: $header, selectedPayTermObj: $selectedPayTermObj, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i17.AppVersionPage]
class AppVersionRoute extends _i22.PageRouteInfo<void> {
  const AppVersionRoute()
      : super(
          AppVersionRoute.name,
          path: '',
        );

  static const String name = 'AppVersionRoute';
}

/// generated route for
/// [_i18.AppVersionFormPage]
class AppVersionFormRoute extends _i22.PageRouteInfo<AppVersionFormRouteArgs> {
  AppVersionFormRoute({
    _i24.Key? key,
    required String header,
    required dynamic onRefresh,
  }) : super(
          AppVersionFormRoute.name,
          path: 'form',
          args: AppVersionFormRouteArgs(
            key: key,
            header: header,
            onRefresh: onRefresh,
          ),
        );

  static const String name = 'AppVersionFormRoute';
}

class AppVersionFormRouteArgs {
  const AppVersionFormRouteArgs({
    this.key,
    required this.header,
    required this.onRefresh,
  });

  final _i24.Key? key;

  final String header;

  final dynamic onRefresh;

  @override
  String toString() {
    return 'AppVersionFormRouteArgs{key: $key, header: $header, onRefresh: $onRefresh}';
  }
}

/// generated route for
/// [_i19.SalesMenuPage]
class SalesMenuRoute extends _i22.PageRouteInfo<void> {
  const SalesMenuRoute()
      : super(
          SalesMenuRoute.name,
          path: 'menu',
        );

  static const String name = 'SalesMenuRoute';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class PriceQuotationWrapper extends _i22.PageRouteInfo<void> {
  const PriceQuotationWrapper({List<_i22.PageRouteInfo>? children})
      : super(
          PriceQuotationWrapper.name,
          path: 'price_quotation/',
          initialChildren: children,
        );

  static const String name = 'PriceQuotationWrapper';
}

/// generated route for
/// [_i20.PriceQuotationPage]
class PriceQuotationRoute extends _i22.PageRouteInfo<void> {
  const PriceQuotationRoute()
      : super(
          PriceQuotationRoute.name,
          path: '',
        );

  static const String name = 'PriceQuotationRoute';
}

/// generated route for
/// [_i21.PriceQuotationHeaderDetailsPage]
class PriceQuotationHeaderDetailsRoute
    extends _i22.PageRouteInfo<PriceQuotationHeaderDetailsRouteArgs> {
  PriceQuotationHeaderDetailsRoute({
    _i24.Key? key,
    required int id,
    String header = "",
  }) : super(
          PriceQuotationHeaderDetailsRoute.name,
          path: ':id',
          args: PriceQuotationHeaderDetailsRouteArgs(
            key: key,
            id: id,
            header: header,
          ),
          rawPathParams: {'id': id},
          rawQueryParams: {'header': header},
        );

  static const String name = 'PriceQuotationHeaderDetailsRoute';
}

class PriceQuotationHeaderDetailsRouteArgs {
  const PriceQuotationHeaderDetailsRouteArgs({
    this.key,
    required this.id,
    this.header = "",
  });

  final _i24.Key? key;

  final int id;

  final String header;

  @override
  String toString() {
    return 'PriceQuotationHeaderDetailsRouteArgs{key: $key, id: $id, header: $header}';
  }
}
