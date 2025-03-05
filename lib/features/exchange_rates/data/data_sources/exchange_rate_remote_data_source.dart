import 'package:dio/dio.dart';
import '../../../../core/utils/constants.dart';
import '../model/exchange_rate_model.dart';
// date: 6 March 2025
// by: Fouad
// last modified at: 6 March 2025
// purpose: Create a class that fetches exchange rates from the API.
// The class takes a Dio object as a parameter and uses it to make requests.

class ExchangeRateRemoteDataSource {
  final Dio dio;

  ExchangeRateRemoteDataSource({required this.dio});

  /// Fetches exchange rates from the remote API for a specified timeframe and currency pair.
  ///
  /// Throws:
  /// - [Exception] if the API call fails or if the response indicates an error.
  ///
  /// Parameters:
  /// - [startDate]: The start date for the exchange rates in YYYY-MM-DD format.
  /// - [endDate]: The end date for the exchange rates in YYYY-MM-DD format.
  /// - [base]: The base currency code (e.g., USD).
  /// - [target]: The target currency code (e.g., EUR).
  ///
  /// Returns:
  /// - A [Future] that completes with an [ExchangeRateModel] containing the exchange rates.

  Future<ExchangeRateModel> getExchangeRates(
    String startDate,
    String endDate,
    String base,
    String target,
  ) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}timeframe',
        queryParameters: {
          'start_date': startDate,
          'end_date': endDate,
          'source': base,
          'access_key': AppConstants.apiKey,
        },
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return ExchangeRateModel.fromJson(response.data, target);
      } else {
        throw Exception("API Error: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to fetch exchange rates: $e");
    }
  }
}
