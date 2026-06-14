class Currency {
  final String code;
  final String name;
  final double rate;

  Currency({
    required this.code,
    required this.name,
    required this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json, String code, String name) {
    return Currency(
      code: code,
      name: name,
      rate: (json[code] ?? 0.0).toDouble(),
    );
  }

  // To store in SharedPreferences if needed
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'rate': rate,
    };
  }

  factory Currency.fromCacheJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      rate: json['rate'],
    );
  }
}
