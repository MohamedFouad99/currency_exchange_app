import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/exchange_rate_entity.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create an abstract class that defines the methods to fetch exchange rates.
abstract class ExchangeRateRepository {
  /// Fetches exchange rates from the repository and returns them as a right value of an Either.
  /// If an error occurs, it returns a left value of an Either with a ServerFailure.
  ///
  /// The error message will include the error message from the remote data source.
  Future<Either<Failure, ExchangeRateEntity>> getExchangeRates(
    String startDate,
    String endDate,
    String base,
    String target,
    int page,
  );
}
