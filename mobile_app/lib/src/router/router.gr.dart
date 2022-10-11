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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:mobile_app/src/global_bloc/bloc_customer/create_customer/bloc.dart'
    as _i16;
import 'package:mobile_app/src/router/router_guard.dart' as _i15;
import 'package:mobile_app/src/screens/login_screen/login_screen.dart' as _i1;
import 'package:mobile_app/src/screens/modules/Dashboard/dashboard.dart' as _i5;
import 'package:mobile_app/src/screens/modules/main_screen.dart' as _i3;
import 'package:mobile_app/src/screens/modules/Master_Data/customer/create_customer/address_form.dart'
    as _i4;
import 'package:mobile_app/src/screens/modules/Master_Data/customer/create_customer/create_customer_screen.dart'
    as _i8;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/cart/main_screen.dart'
    as _i11;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/create_pq_screen.dart'
    as _i6;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/customer_selection/main_screen.dart'
    as _i9;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/product_selection/main_screen.dart'
    as _i10;
import 'package:mobile_app/src/screens/modules/Price_Quotation/price_quotations/pq_base_screen.dart'
    as _i12;
import 'package:mobile_app/src/screens/modules/Price_Quotation/price_quotations/purch_quotations_screen.dart'
    as _i7;
import 'package:mobile_app/src/screens/widgets/success_screen.dart' as _i2;

class AppRouter extends _i13.RootStackRouter {
  AppRouter({
    _i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
    required this.routeGuard,
  }) : super(navigatorKey);

  final _i15.RouteGuard routeGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    SuccessScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessScreenRouteArgs>();
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.SuccessScreen(
          key: args.key,
          message: args.message,
          buttonLabel: args.buttonLabel,
          onButtonPressed: args.onButtonPressed,
          submessage: args.submessage,
        ),
      );
    },
    MainScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.MainScreen(),
      );
    },
    AddressFormScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddressFormScreenRouteArgs>();
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.AddressFormScreen(
          key: args.key,
          createCustomerBloc: args.createCustomerBloc,
        ),
      );
    },
    DashboardScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.DashboardScreen(),
      );
    },
    CreatePriceQuotationScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.CreatePriceQuotationScreen(),
      );
    },
    PriceQuotationScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.PriceQuotationScreen(),
      );
    },
    CreateCustomerScreenRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.CreateCustomerScreen(),
      );
    },
    CustomerSelectionRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i9.CustomerSelectionScreen(),
      );
    },
    ProductionSelectionRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProductSelectionScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.CartScreen(),
      );
    },
    PurchaseQuotationsBaseScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PurchaseQuotationsBaseScreenRouteArgs>();
      return _i13.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i12.PurchaseQuotationsBaseScreen(
          key: args.key,
          startdateController: args.startdateController,
          enddateController: args.enddateController,
          pqStatus: args.pqStatus,
          docStatus: args.docStatus,
        ),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          LoginScreenRoute.name,
          path: '/login',
        ),
        _i13.RouteConfig(
          SuccessScreenRoute.name,
          path: '/success_screen',
        ),
        _i13.RouteConfig(
          MainScreenRoute.name,
          path: '/',
          guards: [routeGuard],
          children: [
            _i13.RouteConfig(
              '#redirect',
              path: '',
              parent: MainScreenRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
            _i13.RouteConfig(
              DashboardScreenRoute.name,
              path: 'dashboard',
              parent: MainScreenRoute.name,
            ),
            _i13.RouteConfig(
              CreatePriceQuotationScreenRoute.name,
              path: 'create_pq',
              parent: MainScreenRoute.name,
              children: [
                _i13.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: CreatePriceQuotationScreenRoute.name,
                  redirectTo: 'select_customer',
                  fullMatch: true,
                ),
                _i13.RouteConfig(
                  CustomerSelectionRoute.name,
                  path: 'select_customer',
                  parent: CreatePriceQuotationScreenRoute.name,
                ),
                _i13.RouteConfig(
                  ProductionSelectionRoute.name,
                  path: 'select_product',
                  parent: CreatePriceQuotationScreenRoute.name,
                ),
                _i13.RouteConfig(
                  CartRoute.name,
                  path: 'select_product',
                  parent: CreatePriceQuotationScreenRoute.name,
                ),
              ],
            ),
            _i13.RouteConfig(
              PriceQuotationScreenRoute.name,
              path: 'price_quotations',
              parent: MainScreenRoute.name,
              children: [
                _i13.RouteConfig(
                  PurchaseQuotationsBaseScreenRoute.name,
                  path: 'my_transaction',
                  parent: PriceQuotationScreenRoute.name,
                )
              ],
            ),
            _i13.RouteConfig(
              CreateCustomerScreenRoute.name,
              path: 'create_customer',
              parent: MainScreenRoute.name,
            ),
          ],
        ),
        _i13.RouteConfig(
          AddressFormScreenRoute.name,
          path: '/address_form',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreenRoute extends _i13.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i2.SuccessScreen]
class SuccessScreenRoute extends _i13.PageRouteInfo<SuccessScreenRouteArgs> {
  SuccessScreenRoute({
    _i14.Key? key,
    required String message,
    required String buttonLabel,
    required void Function(_i14.BuildContext)? onButtonPressed,
    String? submessage,
  }) : super(
          SuccessScreenRoute.name,
          path: '/success_screen',
          args: SuccessScreenRouteArgs(
            key: key,
            message: message,
            buttonLabel: buttonLabel,
            onButtonPressed: onButtonPressed,
            submessage: submessage,
          ),
        );

  static const String name = 'SuccessScreenRoute';
}

class SuccessScreenRouteArgs {
  const SuccessScreenRouteArgs({
    this.key,
    required this.message,
    required this.buttonLabel,
    required this.onButtonPressed,
    this.submessage,
  });

  final _i14.Key? key;

  final String message;

  final String buttonLabel;

  final void Function(_i14.BuildContext)? onButtonPressed;

  final String? submessage;

  @override
  String toString() {
    return 'SuccessScreenRouteArgs{key: $key, message: $message, buttonLabel: $buttonLabel, onButtonPressed: $onButtonPressed, submessage: $submessage}';
  }
}

/// generated route for
/// [_i3.MainScreen]
class MainScreenRoute extends _i13.PageRouteInfo<void> {
  const MainScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MainScreenRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i4.AddressFormScreen]
class AddressFormScreenRoute
    extends _i13.PageRouteInfo<AddressFormScreenRouteArgs> {
  AddressFormScreenRoute({
    _i14.Key? key,
    required _i16.CreateCustomerBloc createCustomerBloc,
  }) : super(
          AddressFormScreenRoute.name,
          path: '/address_form',
          args: AddressFormScreenRouteArgs(
            key: key,
            createCustomerBloc: createCustomerBloc,
          ),
        );

  static const String name = 'AddressFormScreenRoute';
}

class AddressFormScreenRouteArgs {
  const AddressFormScreenRouteArgs({
    this.key,
    required this.createCustomerBloc,
  });

  final _i14.Key? key;

  final _i16.CreateCustomerBloc createCustomerBloc;

  @override
  String toString() {
    return 'AddressFormScreenRouteArgs{key: $key, createCustomerBloc: $createCustomerBloc}';
  }
}

/// generated route for
/// [_i5.DashboardScreen]
class DashboardScreenRoute extends _i13.PageRouteInfo<void> {
  const DashboardScreenRoute()
      : super(
          DashboardScreenRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardScreenRoute';
}

/// generated route for
/// [_i6.CreatePriceQuotationScreen]
class CreatePriceQuotationScreenRoute extends _i13.PageRouteInfo<void> {
  const CreatePriceQuotationScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          CreatePriceQuotationScreenRoute.name,
          path: 'create_pq',
          initialChildren: children,
        );

  static const String name = 'CreatePriceQuotationScreenRoute';
}

/// generated route for
/// [_i7.PriceQuotationScreen]
class PriceQuotationScreenRoute extends _i13.PageRouteInfo<void> {
  const PriceQuotationScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PriceQuotationScreenRoute.name,
          path: 'price_quotations',
          initialChildren: children,
        );

  static const String name = 'PriceQuotationScreenRoute';
}

/// generated route for
/// [_i8.CreateCustomerScreen]
class CreateCustomerScreenRoute extends _i13.PageRouteInfo<void> {
  const CreateCustomerScreenRoute()
      : super(
          CreateCustomerScreenRoute.name,
          path: 'create_customer',
        );

  static const String name = 'CreateCustomerScreenRoute';
}

/// generated route for
/// [_i9.CustomerSelectionScreen]
class CustomerSelectionRoute extends _i13.PageRouteInfo<void> {
  const CustomerSelectionRoute()
      : super(
          CustomerSelectionRoute.name,
          path: 'select_customer',
        );

  static const String name = 'CustomerSelectionRoute';
}

/// generated route for
/// [_i10.ProductSelectionScreen]
class ProductionSelectionRoute extends _i13.PageRouteInfo<void> {
  const ProductionSelectionRoute()
      : super(
          ProductionSelectionRoute.name,
          path: 'select_product',
        );

  static const String name = 'ProductionSelectionRoute';
}

/// generated route for
/// [_i11.CartScreen]
class CartRoute extends _i13.PageRouteInfo<void> {
  const CartRoute()
      : super(
          CartRoute.name,
          path: 'select_product',
        );

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i12.PurchaseQuotationsBaseScreen]
class PurchaseQuotationsBaseScreenRoute
    extends _i13.PageRouteInfo<PurchaseQuotationsBaseScreenRouteArgs> {
  PurchaseQuotationsBaseScreenRoute({
    _i14.Key? key,
    required _i14.TextEditingController startdateController,
    required _i14.TextEditingController enddateController,
    int? pqStatus,
    required String docStatus,
  }) : super(
          PurchaseQuotationsBaseScreenRoute.name,
          path: 'my_transaction',
          args: PurchaseQuotationsBaseScreenRouteArgs(
            key: key,
            startdateController: startdateController,
            enddateController: enddateController,
            pqStatus: pqStatus,
            docStatus: docStatus,
          ),
        );

  static const String name = 'PurchaseQuotationsBaseScreenRoute';
}

class PurchaseQuotationsBaseScreenRouteArgs {
  const PurchaseQuotationsBaseScreenRouteArgs({
    this.key,
    required this.startdateController,
    required this.enddateController,
    this.pqStatus,
    required this.docStatus,
  });

  final _i14.Key? key;

  final _i14.TextEditingController startdateController;

  final _i14.TextEditingController enddateController;

  final int? pqStatus;

  final String docStatus;

  @override
  String toString() {
    return 'PurchaseQuotationsBaseScreenRouteArgs{key: $key, startdateController: $startdateController, enddateController: $enddateController, pqStatus: $pqStatus, docStatus: $docStatus}';
  }
}
