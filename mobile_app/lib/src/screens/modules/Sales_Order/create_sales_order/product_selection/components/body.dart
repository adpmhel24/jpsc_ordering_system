import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_app/src/screens/modules/Sales_Order/create_sales_order/bloc/bloc.dart';
import 'package:mobile_app/src/screens/utils/fetching_status.dart';

import '../../../../../../global_bloc/bloc_product/bloc.dart';
import '../../../../../widgets/custom_animated_dialog.dart';
import '../../../../../widgets/custom_text_field.dart';
import 'grid_view.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      context.read<ProductsBloc>().add(FetchProductWithPriceByLocation(
          context.read<CreateSalesOrderBloc>().state.dispatchingBranch.value));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state.status == FetchingStatus.loading) {
          context.loaderOverlay.show();
        } else if (state.status == FetchingStatus.error) {
          CustomAnimatedDialog.error(context, message: state.message);
        } else {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: CustomTextField(
                controller: _searchController,
                labelText: 'Search',
                onChanged: (value) {
                  context
                      .read<ProductsBloc>()
                      .add(SearchProductByKeyword(value));
                },
                suffixIcon: Builder(builder: (context) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          _refresh();
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ProductGrid(products: state.products),
            ))
            // Expanded(
            //   child: FutureBuilder<List<ProductModel>>(
            //     future: context.read<ProductRepo>().offlineSearch(),
            //     builder: (context, AsyncSnapshot snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text(snapshot.error.toString()),
            //         );
            //       }
            //       switch (snapshot.connectionState) {
            //         case ConnectionState.active:
            //         case ConnectionState.waiting:
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         case ConnectionState.done:
            //           return RefreshIndicator(
            //             onRefresh: () => _refresh(context),
            //             child: ProductGrid(
            //                 products: _searchController.text.isEmpty
            //                     ? snapshot.data
            //                     : snapshot.data
            //                         .where(
            //                           (item) => item.code
            //                               .toLowerCase()
            //                               .contains("atlantic c"),
            //                         )
            //                         .toList()),
            //           );
            //         default:
            //           return const SizedBox.expand();
            //       }
            //     },
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
