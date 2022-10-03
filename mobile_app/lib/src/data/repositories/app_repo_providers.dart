import 'package:flutter_bloc/flutter_bloc.dart';

import '../http_services/ph_location_api/ph_location_api.dart';
import 'repos.dart';

class AppRepoProvider {
  static List<RepositoryProvider> repoProviders = [
    RepositoryProvider<LocalStorageRepo>(
      lazy: false,
      create: (context) => LocalStorageRepo()..init(),
    ),
    RepositoryProvider<PhLocationRepo>(
      create: (context) => PhLocationRepo(PhLocationApiService()),
    ),
    RepositoryProvider<AuthRepo>(
      create: (context) => AuthRepo(),
    ),
    RepositoryProvider<MenuController>(
      create: (context) => MenuController(),
    ),
    RepositoryProvider<SystemUserBranchRepo>(
      create: (context) => SystemUserBranchRepo(
        localStorage: context.read<LocalStorageRepo>().localStorage,
      ),
    ),
    RepositoryProvider<CustomerRepo>(
      create: (context) => CustomerRepo(
        localStorage: context.read<LocalStorageRepo>().localStorage,
      ),
    ),
    RepositoryProvider<ProductRepo>(
      create: (context) => ProductRepo(
        localStorage: context.read<LocalStorageRepo>().localStorage,
      ),
    ),
    RepositoryProvider<BranchRepo>(
      create: (context) => BranchRepo(
        localStorage: context.read<LocalStorageRepo>().localStorage,
      ),
    ),
    RepositoryProvider<PaymentTermRepo>(
      create: (context) => PaymentTermRepo(
        localStorage: context.read<LocalStorageRepo>().localStorage,
      ),
    ),
    ...salesRepo,
  ];
}

final salesRepo = [
  RepositoryProvider<SalesOrderRepo>(
    create: (context) => SalesOrderRepo(
      localStorage: context.read<LocalStorageRepo>().localStorage,
    ),
  ),
];
