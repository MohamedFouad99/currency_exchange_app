import 'package:dio/dio.dart';
import '../../../../core/utils/constants.dart';
import '../model/exchange_rate_model.dart';
// date: 6 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that fetches exchange rates from the API.
// The class takes a Dio object as a parameter and uses it to make requests.

class ExchangeRateRemoteDataSource {
  final Dio dio;

  ExchangeRateRemoteDataSource({required this.dio});

  /// Fetches exchange rates from the API and returns them as a right value of an Either.
  /// If an error occurs, it returns a left value of an Either with a ServerFailure.
  ///
  /// The error message will include the error message from the remote data source.
  ///
  /// The API endpoint is: https://exchangerate-api.com/docs
  ///
  /// The following parameters are required:
  ///
  /// - [startDate]: The start date in the format "yyyy-mm-dd"
  /// - [endDate]: The end date in the format "yyyy-mm-dd"
  /// - [base]: The base currency
  /// - [target]: The target currency
  ///
  /// The response will contain a sorted list of exchange rates by date.
  /// The list will be a map with the keys being the dates and the values being the exchange rate.
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
        final allRates = response.data["quotes"] as Map<String, dynamic>;

        // Convert map entries to a sorted list
        final sortedRates =
            allRates.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

        return ExchangeRateModel.fromJson({
          "quotes": Map.fromEntries(sortedRates),
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
