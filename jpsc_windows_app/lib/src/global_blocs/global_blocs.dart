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
          branchRepo: context.read<BranchRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
      BlocProvider<SystemUsersBloc>(
        create: (_) => SystemUsersBloc(
          systemUserRepo: context.read<SystemUserRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
      BlocProvider<WarehousesBloc>(
        create: (_) => WarehousesBloc(
          warehouseRepo: context.read<WarehouseRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
      BlocProvider<UomsBloc>(
        create: (_) => UomsBloc(
          uomRepo: context.read<UomRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
      BlocProvider<ItemGroupsBloc>(
        create: (_) => ItemGroupsBloc(
          itemGroupRepo: context.read<ItemGroupRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
      BlocProvider<ItemsBloc>(
        create: (_) => ItemsBloc(
          itemRepo: context.read<ProductRepo>(),
          currUserRepo: context.read<CurrentUserRepo>(),
          objectTypeRepo: context.read<ObjectTypeRepo>(),
        ),
      ),
    ];
  }
}
