// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a class that represents the exchange rate entity.
// The entity will be used to pass data between the layers of the application.
// The entity contains the base currency, target currency, and exchange rates.
class ExchangeRateEntity {
  final String base;
  final String target;
  final Map<String, dynamic> rates;

  const ExchangeRateEntity({
    required this.base,
    required this.target,
    required this.rates,
  });
}
