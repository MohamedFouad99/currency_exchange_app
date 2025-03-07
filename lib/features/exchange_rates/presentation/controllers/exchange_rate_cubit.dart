import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/usecases/get_exchange_rates.dart';
import 'exchange_rate_state.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 7 March 2025
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

  /// Fetches the exchange rates from the repository and emits the state based on the result.
  ///
  /// If [loadMore] is true, it fetches the next page of the exchange rates.
  ///
  /// If [isPrevious] is true, it fetches the previous page of the exchange rates.
  ///
  /// If the fields are empty, it emits an [ExchangeRateError] state.
  ///
  /// If the fields are valid, it fetches the exchange rates from the repository.
  void fetchRates({bool loadMore = false, bool isPrevious = false}) async {
    DateTime startDateTime = DateTime.parse(startDate!);
    DateTime endDateTime = DateTime.parse(endDate!);
    int totalDays = endDateTime.difference(startDateTime).inDays;
    emit(ExchangeRateLoading());
    if (_areFieldsEmpty()) {
      emit(ExchangeRateError("Please enter all fields"));
    } else {
      //first page
      if (!loadMore && !isPrevious) {
        _fetchFirstPage(startDateTime, totalDays);
      } else if (isPrevious && _currentPage > 1) {
        //Previous page
        _currentPage--; // Move to previous page
        emit(
          ExchangeRateLoaded(
            base!,
            target!,
            _allRates.sublist(10 * (_currentPage - 1), (10 * _currentPage)),
            false,
            _currentPage == 1,
          ),
        );
      } else if (loadMore && !_isLastPage) {
        //Next page
        _fetchNextPage(startDateTime, totalDays);
      }
    }
  }

  /// Fetches the next page of exchange rates from the repository and emits the state based on the result.
  ///
  /// If the end date is reached, it emits an [ExchangeRateLoaded] state with the isLastPage flag set to true.
  ///
  /// If the next page is not available, it emits an [ExchangeRateError] state.
  void _fetchNextPage(DateTime startDateTime, int totalDays) async {
    _currentPage++; // Move to next page
    if (_allRates.length >= min(_currentPage * 10, totalDays)) {
      emit(
        ExchangeRateLoaded(
          base!,
          target!,
          _allRates.sublist(
            10 * (_currentPage - 1),
            totalDays < 10 * _currentPage ? totalDays + 1 : 10 * _currentPage,
          ),
          totalDays < 10 * _currentPage,
          _currentPage == 1,
        ),
      );
    } else {
      emit(ExchangeRateLoading());
      final Either<Failure, ExchangeRateEntity> result = await getExchangeRates
          .execute(
            DateFormat('yyyy-MM-dd').format(
              startDateTime.add(Duration(days: (_currentPage - 1) * 10)),
            ),
            totalDays > 10 * _currentPage
                ? DateFormat('yyyy-MM-dd').format(
                  startDateTime.add(Duration(days: (_currentPage * 10) - 1)),
                )
                : endDate!,

            base!,
            target!,
            _currentPage,
          );
      result.fold((failure) => emit(ExchangeRateError(failure.message)), (
        exchangeRate,
      ) {
        _allRates.addAll(_convertRates(exchangeRate));
        emit(
          ExchangeRateLoaded(
            exchangeRate.base,
            exchangeRate.target,
            _allRates.sublist(10 * (_currentPage - 1), _allRates.length),
            exchangeRate.rates.keys.lastOrNull == endDate,
            _currentPage == 1,
          ),
        );
      });
    }
  }

  ///Resets pagination for the first fetch
  void _resetPagination() {
    _currentPage = 1;
    _allRates.clear();
    _isLastPage = false;
  }

  /// Fetches the first page of exchange rates and updates the state accordingly.
  ///
  /// This method resets pagination and emits a loading state before fetching.
  /// It uses the provided [startDateTime] and [totalDays] to determine the date range
  /// for the first page request. If the fetch is successful, it converts the rates
  /// and emits a loaded state with the exchange rates. If an error occurs, it emits
  /// an error state with the failure message.

  void _fetchFirstPage(DateTime startDateTime, int totalDays) async {
    _resetPagination();
    emit(ExchangeRateLoading());
    final Either<Failure, ExchangeRateEntity> result = await getExchangeRates
        .execute(
          startDate!,
          totalDays > 10
              ? DateFormat(
                'yyyy-MM-dd',
              ).format(startDateTime.add(Duration(days: 9)))
              : endDate!,
          base!,
          target!,
          _currentPage,
        );
    result.fold((failure) => emit(ExchangeRateError(failure.message)), (
      exchangeRate,
    ) {
      _allRates = _convertRates(exchangeRate);
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

  /// Converts the exchange rate map from the entity to a list of map entries
  /// where the key is the date in the format 'yyyy-MM-dd' and the value is the
  /// exchange rate as a double.
  List<MapEntry<String, double>> _convertRates(
    ExchangeRateEntity exchangeRate,
  ) {
    return exchangeRate.rates.entries
        .map((entry) => MapEntry(entry.key, entry.value as double))
        .toList();
  }

  /// Checks if any of the mandatory fields required for fetching
  /// exchange rates are empty or null.
  bool _areFieldsEmpty() {
    return startDate == null ||
        endDate == null ||
        base == null ||
        target == null;
  }
}
