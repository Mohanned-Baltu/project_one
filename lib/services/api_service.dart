import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/currency.dart';
import '../core/exceptions.dart';

/// Service responsible for fetching currency exchange rates from a public API.
class ApiService {
  static const String _baseUrl = 'https://open.er-api.com/v6/latest/USD';

  static const Map<String, String> _currencyNames = {
    'USD': 'US Dollar',
    'EUR': 'Euro',
    'JPY': 'Japanese Yen',
    'GBP': 'British Pound Sterling',
    'AUD': 'Australian Dollar',
    'CAD': 'Canadian Dollar',
    'CHF': 'Swiss Franc',
    'CNY': 'Chinese Yuan',
    'HKD': 'Hong Kong Dollar',
    'NZD': 'New Zealand Dollar',
    'SEK': 'Swedish Krona',
    'KRW': 'South Korean Won',
    'SGD': 'Singapore Dollar',
    'NOK': 'Norwegian Krone',
    'MXN': 'Mexican Peso',
    'INR': 'Indian Rupee',
    'RUB': 'Russian Ruble',
    'ZAR': 'South African Rand',
    'TRY': 'Turkish Lira',
    'BRL': 'Brazilian Real',
    'TWD': 'New Taiwan Dollar',
    'DKK': 'Danish Krone',
    'PLN': 'Polish Zloty',
    'THB': 'Thai Baht',
    'IDR': 'Indonesian Rupiah',
    'HUF': 'Hungarian Forint',
    'CZK': 'Czech Koruna',
    'ILS': 'Israeli New Sheqel',
    'CLP': 'Chilean Peso',
    'PHP': 'Philippine Peso',
    'AED': 'United Arab Emirates Dirham',
    'COP': 'Colombian Peso',
    'SAR': 'Saudi Riyal',
    'MYR': 'Malaysian Ringgit',
    'RON': 'Romanian Leu',
  };

  /// Fetches live exchange rates and returns a map containing the list of [Currency] objects and the last update time.
  /// Throws [NetworkException] if connection fails.
  /// Throws [ApiException] if server returns an error.
  /// Throws [ParseException] if JSON parsing fails.
  Future<Map<String, dynamic>> fetchRates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);

          final Map<String, dynamic> ratesJson = data['rates'] ?? {};
          final String lastUpdate = data['time_last_update_utc']?.toString() ?? 'Unknown';

          List<Currency> currencies = [];
          ratesJson.forEach((code, rate) {
            currencies.add(Currency(
              code: code,
              name: _currencyNames[code] ?? code,
              rate: (rate is num) ? rate.toDouble() : 0.0,
            ));
          });

          return {
            'currencies': currencies,
            'lastUpdate': lastUpdate,
          };
        } catch (e) {
          throw ParseException();
        }
      } else {
        throw ApiException();
      }
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      if (e is AppExceptions) rethrow;
      throw NetworkException(e.toString());
    }
  }
}
