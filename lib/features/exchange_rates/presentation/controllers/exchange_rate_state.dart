// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a class that represents the state of the exchange rate feature.
// The state will be used to manage the UI state of the exchange rate feature.
abstract class ExchangeRateState {}

class ExchangeRateInitial extends ExchangeRateState {}

class ExchangeRateLoading extends ExchangeRateState {}

class ExchangeRateLoaded extends ExchangeRateState {
  final String base;
  final String target;
  final List<MapEntry<String, double>> rates;
  final bool isLastPage;
  final bool isFirstPage;

  ExchangeRateLoaded(
    this.base,
    this.target,
    this.rates,
    this.isLastPage,
    this.isFirstPage,
  );
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  ExchangeRateError(this.message);
}
