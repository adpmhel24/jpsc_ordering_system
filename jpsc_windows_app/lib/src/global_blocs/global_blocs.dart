import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/repos.dart';
import 'bloc_warehouses/bloc.dart';
import 'blocs.dart';

class GlobalBlocs {
  static List<BlocProvider> blocs(BuildContext context) {
    return [
      BlocProvider<BranchesBloc>(
        create: (_) => BranchesBloc(
          context.read<BranchRepo>(),
        ),
      ),
      BlocProvider<SystemUsersBloc>(
        create: (_) => SystemUsersBloc(
          context.read<SystemUserRepo>(),
        ),
      ),
      BlocProvider<WarehousesBloc>(
        create: (_) => WarehousesBloc(
          context.read<WarehouseRepo>(),
        ),
      ),
      BlocProvider<UomsBloc>(
        create: (_) => UomsBloc(
          context.read<UomRepo>(),
        ),
      ),
      BlocProvider<ItemGroupsBloc>(
        create: (_) => ItemGroupsBloc(
          context.read<ItemGroupRepo>(),
        ),
      ),
      BlocProvider<ItemsBloc>(
        create: (_) => ItemsBloc(
          context.read<ProductRepo>(),
        ),
      ),
    ];
  }
}
