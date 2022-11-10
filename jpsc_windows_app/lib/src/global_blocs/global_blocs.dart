import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/repos.dart';
import 'bloc_warehouses/bloc.dart';

class GlobalBlocs {
  static List<BlocProvider> blocs(BuildContext context) {
    return [
      BlocProvider<WarehousesBloc>(
        create: (_) => WarehousesBloc(
          warehouseRepo: context.read<WarehouseRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
    ];
  }
}
