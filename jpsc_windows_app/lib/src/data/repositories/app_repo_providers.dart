import 'package:flutter_bloc/flutter_bloc.dart';

import 'repos.dart';

class AppRepoProvider {
  static List<RepositoryProvider> repoProviders = [
    RepositoryProvider<LocalStorageRepo>(
      lazy: false,
      create: (context) => LocalStorageRepo()..init(),
    ),
    RepositoryProvider<AuthRepo>(
      create: (context) => AuthRepo(),
    ),
    ...salesProviders,
    ...masterDataProviders,
    ...inventoryProviders,
  ];
}

List<RepositoryProvider> masterDataProviders = [
  RepositoryProvider<SystemUserRepo>(
    create: (context) => SystemUserRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<SystemUserPositionRepo>(
    create: (context) => SystemUserPositionRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<SystemUserBranchRepo>(
    create: (context) => SystemUserBranchRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<BranchRepo>(
    create: (context) => BranchRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<PricelistRepo>(
    create: (context) => PricelistRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<ItemGroupRepo>(
    create: (context) => ItemGroupRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<UomRepo>(
    create: (context) => UomRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<UomGroupRepo>(
    create: (context) => UomGroupRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<ProductRepo>(
    create: (context) => ProductRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<CustomerRepo>(
    create: (context) => CustomerRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<PaymentTermRepo>(
    create: (context) => PaymentTermRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
];

List<RepositoryProvider> salesProviders = [
  RepositoryProvider<SalesOrderRepo>(
    create: (context) => SalesOrderRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
];

List<RepositoryProvider> inventoryProviders = [
  RepositoryProvider<InvAdjustmentInRepo>(
    create: (context) => InvAdjustmentInRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<InvAdjustmentOutRepo>(
    create: (context) => InvAdjustmentOutRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
];
