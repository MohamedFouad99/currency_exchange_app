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
  static const int pageSize = 10; // Fetch 10 records per request
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
    int page,
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
        final allRates = response.data["quotes"] as Map<String, dynamic>;

        // Convert map entries to a sorted list
        final sortedRates =
            allRates.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

        // Pagination: extract only the required range of data
        final startIdx = (page - 1) * pageSize;
        final endIdx = startIdx + pageSize;
        final paginatedRates = sortedRates.sublist(
          startIdx,
          endIdx.clamp(0, sortedRates.length),
        );
        return ExchangeRateModel.fromJson({
          "quotes": Map.fromEntries(paginatedRates),
          "source": base,
        }, target);
      } else {
        throw Exception("API Error: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to fetch exchange rates: $e");
    }
  }
}
