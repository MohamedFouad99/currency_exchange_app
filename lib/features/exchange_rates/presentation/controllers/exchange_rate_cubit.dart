import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/usecases/get_exchange_rates.dart';
import 'exchange_rate_state.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a cubit class that fetches exchange rates from the repository.
// The cubit class extends the Cubit class and implements the fetchRates method.
// The cubit class emits states based on the result of the exchange rate use case.
class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final GetExchangeRates getExchangeRates;
  int _currentPage = 1;
  List<MapEntry<String, double>> _allRates = []; // Stores fetched data
  bool _isLastPage = false;
  ExchangeRateCubit(this.getExchangeRates) : super(ExchangeRateInitial());
  String? startDate;
  String? endDate;
  String? base;
  String? target;
  void setStartDate(String date) {
    startDate = date;
    emit(ExchangeRateInitial());
  }

  void setEndDate(String date) {
    endDate = date;
    emit(ExchangeRateInitial());
  }

  void setBase(String currency) {
    base = currency;
  }

  void setTarget(String currency) {
    target = currency;
  }

  /// Fetches exchange rates for the given date range and currency pair.
  ///
  /// Emits [ExchangeRateLoading] state before starting the fetch operation.
  /// Then, attempts to execute the exchange rate retrieval use case with the
  /// provided [startDate], [endDate], [base], and [target] parameters.
  ///
  /// If successful, emits [ExchangeRateLoaded] with the retrieved data.
  /// If an error occurs, emits [ExchangeRateError] with the failure message.
  ///
  /// [startDate] and [endDate] should be in the format 'YYYY-MM-DD'.
  /// [base] is the base currency code (e.g., 'USD').
  /// [target] is the target currency code (e.g., 'EUR').

  void fetchRates({bool loadMore = false, bool isPrevious = false}) async {
    emit(ExchangeRateLoading());
    if (startDate == null ||
        endDate == null ||
        base == null ||
        target == null) {
      emit(ExchangeRateError("Please enter all fields"));
    } else {
      if (!loadMore && !isPrevious) {
        _currentPage = 1;
        _allRates.clear();
        _isLastPage = false;
        emit(ExchangeRateLoading());
      } else if (isPrevious && _currentPage > 1) {
        _currentPage--; // Move to previous page
      } else if (loadMore && !_isLastPage) {
        _currentPage++; // Move to next page
      }

      final Either<Failure, ExchangeRateEntity> result = await getExchangeRates
          .execute(startDate!, endDate!, base!, target!, _currentPage);
      result.fold((failure) => emit(ExchangeRateError(failure.message)), (
        exchangeRate,
      ) {
        _allRates =
            exchangeRate.rates.entries
                .map((entry) => MapEntry(entry.key, entry.value as double))
                .toList();
        emit(
          ExchangeRateLoaded(
            exchangeRate.base,
            exchangeRate.target,
            _allRates,
            exchangeRate.rates.keys.lastOrNull == endDate,
            _currentPage == 1,
          ),
        );
      });
    }
  }
}
