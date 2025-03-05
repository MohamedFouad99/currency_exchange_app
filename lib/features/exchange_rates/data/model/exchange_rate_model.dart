import '../../domain/entities/exchange_rate_entity.dart';

// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a model class that extends the ExchangeRateEntity class
// to parse the response from the API into a model object.
// The model object will be used to display the exchange rates in the UI.
class ExchangeRateModel extends ExchangeRateEntity {
  const ExchangeRateModel({
    required super.base,
    required super.target,
    required Map<String, double> super.rates,
  });

  factory ExchangeRateModel.fromJson(
    Map<String, dynamic> json,
    String targetCurrency,
  ) {
    Map<String, double> extractedRates = {};

    // The response contains exchange rates inside 'quotes'
    Map<String, dynamic> quotes = json['quotes'];

    quotes.forEach((date, values) {
      // The key format is "USDGBP", "USDEUR" .
      String key = json['source'] + targetCurrency;

      if (values.containsKey(key)) {
        extractedRates[date] = (values[key] as double).toDouble();
      }
    });

    return ExchangeRateModel(
      base: json['source'],
      target: targetCurrency,
      rates: extractedRates,
    );
  }
}
