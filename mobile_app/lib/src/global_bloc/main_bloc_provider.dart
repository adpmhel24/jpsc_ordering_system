import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/repos.dart';
import 'bloc_product/bloc.dart';

class MainScreenBlocProvider {
  static final blocs = [
    BlocProvider(
        create: (context) => ProductsBloc(context.read<ProductRepo>())),
  ];
}
