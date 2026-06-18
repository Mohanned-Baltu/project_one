/// Represents a currency with its code, name, and exchange rate relative to a base currency.
class Currency {
  /// The 3-letter currency code (e.g., USD, EUR).
  final String code;

  /// The full name of the currency.
  final String name;

  /// The exchange rate of the currency.
  final double rate;

  const Currency({
    required this.code,
    required this.name,
    required this.rate,
  });

  /// Creates a [Currency] object from the API response JSON.
  factory Currency.fromJson(Map<String, dynamic> json, String code, String name) {
    return Currency(
      code: code,
      name: name,
      rate: (json[code] ?? 0.0).toDouble(),
    );
  }

  /// Converts the [Currency] to a JSON map for local storage.
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'rate': rate,
    };
  }

  /// Creates a [Currency] object from locally cached JSON data safely.
  /// Provides fallback values if the JSON structure is malformed or missing fields.
  factory Currency.fromCacheJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code']?.toString() ?? 'UNK',
      name: json['name']?.toString() ?? 'Unknown Currency',
      rate: (json['rate'] is num) ? (json['rate'] as num).toDouble() : 0.0,
    );
  }
}
