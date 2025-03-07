import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/repositories/exchange_rate_repository.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/exchange_rate_remote_data_source.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a repository implementation class that fetches exchange rates from the remote data source.
// The class extends the ExchangeRateRepository class and implements the getExchangeRates method.
class ExchangeRateRepositoryImpl extends ExchangeRateRepository {
  final ExchangeRateRemoteDataSource remoteDataSource;

  ExchangeRateRepositoryImpl(this.remoteDataSource);

  @override
  /// Fetches exchange rates from the remote data source and returns them as a right value of an Either.
  /// If an error occurs, it returns a left value of an Either with a ServerFailure.
  ///
  /// The error message will include the error message from the remote data source.
  Future<Either<Failure, ExchangeRateEntity>> getExchangeRates(
    String startDate,
    String endDate,
    String base,
    String target,
  ) async {
    try {
      final result = await remoteDataSource.getExchangeRates(
        startDate,
        endDate,
        base,
        target,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
