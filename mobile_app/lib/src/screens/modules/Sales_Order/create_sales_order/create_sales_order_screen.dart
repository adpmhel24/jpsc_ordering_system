import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_app/src/data/repositories/repos.dart';
import 'package:mobile_app/src/router/router.gr.dart';

import '../../../../global_bloc/bloc_product/bloc.dart';
import '../../../widgets/custom_animated_dialog.dart';
import 'bloc/bloc.dart';
import 'cart/main_screen.dart';
import 'customer_selection/main_screen.dart';
import 'product_selection/main_screen.dart';

class CreateSalesOrderScreen extends StatefulWidget {
  const CreateSalesOrderScreen({Key? key}) : super(key: key);

  static const childrenRoutes = [
    AutoRoute(
      page: CustomerSelectionScreen,
      name: CustomerSelectionScreen.routeName,
      path: "select_customer",
      initial: true,
    ),
    AutoRoute(
      page: ProductSelectionScreen,
      name: ProductSelectionScreen.routeName,
      path: "select_product",
    ),
    AutoRoute(
      page: CartScreen,
      name: CartScreen.routeName,
      path: "select_product",
    ),
  ];

  @override
  State<CreateSalesOrderScreen> createState() => _CreateSalesOrderScreenState();
}

class _CreateSalesOrderScreenState extends State<CreateSalesOrderScreen> {
  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (context) => CreateSalesOrderBloc(context.read<SalesOrderRepo>()),
      child: BlocListener<CreateSalesOrderBloc, CreateSalesOrderState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            CustomAnimatedDialog.error(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            context.router.replace(
              SuccessScreenRoute(
                message: state.message,
                submessage: "Thank you! "
                    "We will get in touch with you shortly to confirm your order.",
                buttonLabel: "Go Back To Menu",
                onButtonPressed: (cntx) {
                  cntx.router.replace(
                    const MainScreenRoute(
                      children: [
                        CreateSalesOrderScreenRoute(),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
        child: AutoTabsRouter(
          routes: const [
            CustomerSelectionRoute(),
            ProductionSelectionRoute(),
            CartRoute()
          ],
          builder: (context, child, animation) {
            final tabsRouter = AutoTabsRouter.of(context);

            return Scaffold(
              body: FadeTransition(
                opacity: animation,
                child: child,
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 10,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  if (index == 1) {
                    context.read<ProductsBloc>().add(
                        FetchProductWithPriceByLocation(context
                            .read<CreateSalesOrderBloc>()
                            .state
                            .dispatchingBranch
                            .value));
                  }
                  tabsRouter.setActiveIndex(index);
                },
                items: [
                  const BottomNavigationBarItem(
                    label: 'Customer',
                    icon: ImageIcon(
                      AssetImage('assets/icons/account.png'),
                    ),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Products',
                    icon: ImageIcon(
                      AssetImage('assets/icons/product.png'),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Carts',
                    icon: Badge(
                      badgeContent: BlocBuilder<CreateSalesOrderBloc,
                          CreateSalesOrderState>(
                        buildWhen: (previous, current) =>
                            previous.cartItems != current.cartItems,
                        builder: (context, state) {
                          return Text("${state.cartItems.value.length}");
                        },
                      ),
                      child: const ImageIcon(
                        AssetImage('assets/icons/shopping-cart.png'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
