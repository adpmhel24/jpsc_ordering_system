import 'package:flutter_bloc/flutter_bloc.dart';

import '../http_services/ph_location_api/ph_location_api.dart';
import 'repo_app_version.dart';
import 'repos.dart';

class AppRepoProvider {
  static List<RepositoryProvider> repoProviders = [
    RepositoryProvider<LocalStorageRepo>(
      lazy: false,
      create: (context) => LocalStorageRepo()..init(),
    ),
    RepositoryProvider<CurrentUserRepo>(
      create: (context) => CurrentUserRepo(),
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
  RepositoryProvider<ObjectTypeRepo>(
    create: (context) => ObjectTypeRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<MenuGroupRepo>(
    create: (context) => MenuGroupRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<AuthorizationRepo>(
    create: (context) => AuthorizationRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<ItemGroupAuthRepo>(
    create: (context) => ItemGroupAuthRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<AppVersionRepo>(
    create: (context) => AppVersionRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
  RepositoryProvider<PhLocationRepo>(
    create: (context) => PhLocationRepo(PhLocationApiService()),
  ),
];

List<RepositoryProvider> salesProviders = [
  RepositoryProvider<PriceQuotationRepo>(
    create: (context) => PriceQuotationRepo(
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
