import 'package:flutter/foundation.dart';
import '../models/currency.dart';
import '../services/api_service.dart';

class CurrencyProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Currency> _allCurrencies = [];
  List<Currency> _filteredCurrencies = [];

  bool _isLoading = true;
  String? _error;
  String _lastUpdate = '';
  String _searchQuery = '';

  List<Currency> get currencies => _searchQuery.isEmpty ? _allCurrencies : _filteredCurrencies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get lastUpdate => _lastUpdate;

  CurrencyProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchRates();
      _allCurrencies = result['currencies'];
      _lastUpdate = result['lastUpdate'];
      _filterCurrencies();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _filterCurrencies();
    notifyListeners();
  }

  void _filterCurrencies() {
    if (_searchQuery.isEmpty) {
      _filteredCurrencies = _allCurrencies;
    } else {
      _filteredCurrencies = _allCurrencies.where((c) {
        return c.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               c.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }
}
