import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/exchange_rates/data/data_sources/exchange_rate_remote_data_source.dart';
import '../../features/exchange_rates/data/repo/exchange_rate_repo_impl.dart';
import '../../features/exchange_rates/domain/repositories/exchange_rate_repository.dart';
import '../../features/exchange_rates/domain/usecases/get_exchange_rates.dart';
import '../../features/exchange_rates/presentation/controllers/exchange_rate_cubit.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a dependency injection file that registers all the dependencies.
// The dependencies include the Dio client, data source, repository, use case, and cubit.
// The dependencies are registered using the GetIt package.
final getIt = GetIt.instance;

void init() {
  // Register Dio Client
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register Data Source
  getIt.registerLazySingleton<ExchangeRateRemoteDataSource>(
    () => ExchangeRateRemoteDataSource(dio: getIt<Dio>()),
  );

  // Register Repository
  getIt.registerLazySingleton<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(getIt()),
  );

  // Register Use Case
  getIt.registerLazySingleton(() => GetExchangeRates(getIt()));

  // Register Cubit
  getIt.registerFactory(() => ExchangeRateCubit(getIt()));
}
