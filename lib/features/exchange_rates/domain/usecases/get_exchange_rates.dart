import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/exchange_rate_entity.dart';
import '../repositories/exchange_rate_repository.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a use case class that fetches exchange rates from the repository.
class GetExchangeRates {
  final ExchangeRateRepository repository;
  GetExchangeRates(this.repository);

  /// Fetches exchange rates from the repository and returns them as a right value of an Either.
  /// If an error occurs, it returns a left value of an Either with a ServerFailure.
  ///
  /// The error message will include the error message from the remote data source.
  Future<Either<Failure, ExchangeRateEntity>> execute(
    String startDate,
    String endDate,
    String base,
    String target,
  ) {
    return repository.getExchangeRates(startDate, endDate, base, target);
  }
}
