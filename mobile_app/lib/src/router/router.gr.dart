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
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:auto_route/empty_router_widgets.dart' as _i3;
import 'package:flutter/material.dart' as _i16;
import 'package:mobile_app/src/data/models/models.dart' as _i17;
import 'package:mobile_app/src/screens/login_screen/login_screen.dart' as _i1;
import 'package:mobile_app/src/screens/modules/main_screen.dart' as _i4;
import 'package:mobile_app/src/screens/modules/Master_Data/customer/create_customer/address_form.dart'
    as _i5;
import 'package:mobile_app/src/screens/modules/Master_Data/customer/create_customer/create_customer_screen.dart'
    as _i9;
import 'package:mobile_app/src/screens/modules/My_Profile/my_profile.dart'
    as _i10;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/cart/main_screen.dart'
    as _i13;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/create_pq_screen.dart'
    as _i7;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/customer_selection/main_screen.dart'
    as _i11;
import 'package:mobile_app/src/screens/modules/Price_Quotation/create_price_quotation/product_selection/main_screen.dart'
    as _i12;
import 'package:mobile_app/src/screens/modules/Price_Quotation/price_quotations/pq_base_screen.dart'
    as _i14;
import 'package:mobile_app/src/screens/modules/Price_Quotation/price_quotations/purch_quotations_screen.dart'
    as _i8;
import 'package:mobile_app/src/screens/new_version_screen/new_version_screen.dart'
    as _i2;
import 'package:mobile_app/src/screens/widgets/success_screen.dart' as _i6;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    NewVersionScreenRoute.name: (routeData) {
      final args = routeData.argsAs<NewVersionScreenRouteArgs>();
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.NewVersionScreen(
          key: args.key,
          activeVersion: args.activeVersion,
        ),
      );
    },
    NavigationHandlerRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.EmptyRouterPage(),
      );
    },
    MainScreenRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.MainScreen(),
      );
    },
    AddressFormScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddressFormScreenRouteArgs>();
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.AddressFormScreen(
          key: args.key,
          onSubmit: args.onSubmit,
        ),
      );
    },
    SuccessScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SuccessScreenRouteArgs>();
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.SuccessScreen(
          key: args.key,
          message: args.message,
          buttonLabel: args.buttonLabel,
          onButtonPressed: args.onButtonPressed,
          submessage: args.submessage,
        ),
      );
    },
    CreatePriceQuotationScreenRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.CreatePriceQuotationScreen(),
      );
    },
    PriceQuotationScreenRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.PriceQuotationScreen(),
      );
    },
    CreateCustomerScreenRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i9.CreateCustomerScreen(),
      );
    },
    MyProfilePageRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.MyProfilePage(),
      );
    },
    CustomerSelectionRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.CustomerSelectionScreen(),
      );
    },
    ProductionSelectionRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.ProductSelectionScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.CartScreen(),
      );
    },
    PurchaseQuotationsBaseScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PurchaseQuotationsBaseScreenRouteArgs>();
      return _i15.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i14.PurchaseQuotationsBaseScreen(
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
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          LoginScreenRoute.name,
          path: '/login',
        ),
        _i15.RouteConfig(
          NewVersionScreenRoute.name,
          path: '/new_version',
        ),
        _i15.RouteConfig(
          NavigationHandlerRoute.name,
          path: '/',
          children: [
            _i15.RouteConfig(
              MainScreenRoute.name,
              path: '',
              parent: NavigationHandlerRoute.name,
              children: [
                _i15.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MainScreenRoute.name,
                  redirectTo: 'create_pq',
                  fullMatch: true,
                ),
                _i15.RouteConfig(
                  CreatePriceQuotationScreenRoute.name,
                  path: 'create_pq',
                  parent: MainScreenRoute.name,
                  children: [
                    _i15.RouteConfig(
                      '#redirect',
                      path: '',
                      parent: CreatePriceQuotationScreenRoute.name,
                      redirectTo: 'select_customer',
                      fullMatch: true,
                    ),
                    _i15.RouteConfig(
                      CustomerSelectionRoute.name,
                      path: 'select_customer',
                      parent: CreatePriceQuotationScreenRoute.name,
                    ),
                    _i15.RouteConfig(
                      ProductionSelectionRoute.name,
                      path: 'select_product',
                      parent: CreatePriceQuotationScreenRoute.name,
                    ),
                    _i15.RouteConfig(
                      CartRoute.name,
                      path: 'select_product',
                      parent: CreatePriceQuotationScreenRoute.name,
                    ),
                  ],
                ),
                _i15.RouteConfig(
                  PriceQuotationScreenRoute.name,
                  path: 'price_quotations',
                  parent: MainScreenRoute.name,
                  children: [
                    _i15.RouteConfig(
                      PurchaseQuotationsBaseScreenRoute.name,
                      path: 'my_transaction',
                      parent: PriceQuotationScreenRoute.name,
                    )
                  ],
                ),
                _i15.RouteConfig(
                  CreateCustomerScreenRoute.name,
                  path: 'create_customer',
                  parent: MainScreenRoute.name,
                ),
                _i15.RouteConfig(
                  MyProfilePageRoute.name,
                  path: 'my_profile',
                  parent: MainScreenRoute.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              AddressFormScreenRoute.name,
              path: 'address_form',
              parent: NavigationHandlerRoute.name,
            ),
            _i15.RouteConfig(
              SuccessScreenRoute.name,
              path: 'success_screen',
              parent: NavigationHandlerRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreenRoute extends _i15.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i2.NewVersionScreen]
class NewVersionScreenRoute
    extends _i15.PageRouteInfo<NewVersionScreenRouteArgs> {
  NewVersionScreenRoute({
    _i16.Key? key,
    required _i17.AppVersionModel activeVersion,
  }) : super(
          NewVersionScreenRoute.name,
          path: '/new_version',
          args: NewVersionScreenRouteArgs(
            key: key,
            activeVersion: activeVersion,
          ),
        );

  static const String name = 'NewVersionScreenRoute';
}

class NewVersionScreenRouteArgs {
  const NewVersionScreenRouteArgs({
    this.key,
    required this.activeVersion,
  });

  final _i16.Key? key;

  final _i17.AppVersionModel activeVersion;

  @override
  String toString() {
    return 'NewVersionScreenRouteArgs{key: $key, activeVersion: $activeVersion}';
  }
}

/// generated route for
/// [_i3.EmptyRouterPage]
class NavigationHandlerRoute extends _i15.PageRouteInfo<void> {
  const NavigationHandlerRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NavigationHandlerRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'NavigationHandlerRoute';
}

/// generated route for
/// [_i4.MainScreen]
class MainScreenRoute extends _i15.PageRouteInfo<void> {
  const MainScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MainScreenRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i5.AddressFormScreen]
class AddressFormScreenRoute
    extends _i15.PageRouteInfo<AddressFormScreenRouteArgs> {
  AddressFormScreenRoute({
    _i16.Key? key,
    required void Function(Map<String, dynamic>) onSubmit,
  }) : super(
          AddressFormScreenRoute.name,
          path: 'address_form',
          args: AddressFormScreenRouteArgs(
            key: key,
            onSubmit: onSubmit,
          ),
        );

  static const String name = 'AddressFormScreenRoute';
}

class AddressFormScreenRouteArgs {
  const AddressFormScreenRouteArgs({
    this.key,
    required this.onSubmit,
  });

  final _i16.Key? key;

  final void Function(Map<String, dynamic>) onSubmit;

  @override
  String toString() {
    return 'AddressFormScreenRouteArgs{key: $key, onSubmit: $onSubmit}';
  }
}

/// generated route for
/// [_i6.SuccessScreen]
class SuccessScreenRoute extends _i15.PageRouteInfo<SuccessScreenRouteArgs> {
  SuccessScreenRoute({
    _i16.Key? key,
    required String message,
    required String buttonLabel,
    required void Function(_i16.BuildContext)? onButtonPressed,
    String? submessage,
  }) : super(
          SuccessScreenRoute.name,
          path: 'success_screen',
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

  final _i16.Key? key;

  final String message;

  final String buttonLabel;

  final void Function(_i16.BuildContext)? onButtonPressed;

  final String? submessage;

  @override
  String toString() {
    return 'SuccessScreenRouteArgs{key: $key, message: $message, buttonLabel: $buttonLabel, onButtonPressed: $onButtonPressed, submessage: $submessage}';
  }
}

/// generated route for
/// [_i7.CreatePriceQuotationScreen]
class CreatePriceQuotationScreenRoute extends _i15.PageRouteInfo<void> {
  const CreatePriceQuotationScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CreatePriceQuotationScreenRoute.name,
          path: 'create_pq',
          initialChildren: children,
        );

  static const String name = 'CreatePriceQuotationScreenRoute';
}

/// generated route for
/// [_i8.PriceQuotationScreen]
class PriceQuotationScreenRoute extends _i15.PageRouteInfo<void> {
  const PriceQuotationScreenRoute({List<_i15.PageRouteInfo>? children})
      : super(
          PriceQuotationScreenRoute.name,
          path: 'price_quotations',
          initialChildren: children,
        );

  static const String name = 'PriceQuotationScreenRoute';
}

/// generated route for
/// [_i9.CreateCustomerScreen]
class CreateCustomerScreenRoute extends _i15.PageRouteInfo<void> {
  const CreateCustomerScreenRoute()
      : super(
          CreateCustomerScreenRoute.name,
          path: 'create_customer',
        );

  static const String name = 'CreateCustomerScreenRoute';
}

/// generated route for
/// [_i10.MyProfilePage]
class MyProfilePageRoute extends _i15.PageRouteInfo<void> {
  const MyProfilePageRoute()
      : super(
          MyProfilePageRoute.name,
          path: 'my_profile',
        );

  static const String name = 'MyProfilePageRoute';
}

/// generated route for
/// [_i11.CustomerSelectionScreen]
class CustomerSelectionRoute extends _i15.PageRouteInfo<void> {
  const CustomerSelectionRoute()
      : super(
          CustomerSelectionRoute.name,
          path: 'select_customer',
        );

  static const String name = 'CustomerSelectionRoute';
}

/// generated route for
/// [_i12.ProductSelectionScreen]
class ProductionSelectionRoute extends _i15.PageRouteInfo<void> {
  const ProductionSelectionRoute()
      : super(
          ProductionSelectionRoute.name,
          path: 'select_product',
        );

  static const String name = 'ProductionSelectionRoute';
}

/// generated route for
/// [_i13.CartScreen]
class CartRoute extends _i15.PageRouteInfo<void> {
  const CartRoute()
      : super(
          CartRoute.name,
          path: 'select_product',
        );

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i14.PurchaseQuotationsBaseScreen]
class PurchaseQuotationsBaseScreenRoute
    extends _i15.PageRouteInfo<PurchaseQuotationsBaseScreenRouteArgs> {
  PurchaseQuotationsBaseScreenRoute({
    _i16.Key? key,
    required _i16.TextEditingController startdateController,
    required _i16.TextEditingController enddateController,
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

  final _i16.Key? key;

  final _i16.TextEditingController startdateController;

  final _i16.TextEditingController enddateController;

  final int? pqStatus;

  final String docStatus;

  @override
  String toString() {
    return 'PurchaseQuotationsBaseScreenRouteArgs{key: $key, startdateController: $startdateController, enddateController: $enddateController, pqStatus: $pqStatus, docStatus: $docStatus}';
  }
}
