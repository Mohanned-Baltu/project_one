import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/currency.dart';

class ApiService {
  // Using a free open API for exchange rates. USD is base by default in this API.
  static const String _baseUrl = 'https://open.er-api.com/v6/latest/USD';

  // Fallback map of currency names since API only provides codes.
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

  Future<Map<String, dynamic>> fetchRates() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final Map<String, dynamic> ratesJson = data['rates'];
        final String lastUpdate = data['time_last_update_utc'] ?? '';

        List<Currency> currencies = [];
        ratesJson.forEach((code, rate) {
          currencies.add(Currency(
            code: code,
            name: _currencyNames[code] ?? code,
            rate: rate.toDouble(),
          ));
        });

        return {
          'currencies': currencies,
          'lastUpdate': lastUpdate,
        };
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
