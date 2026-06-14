import 'package:flutter/foundation.dart';
import '../models/currency.dart';
import '../services/api_service.dart';
import '../core/exceptions.dart';

/// Manages the state of currencies, handles API requests, and provides search functionality.
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

  /// Fetches live exchange rates from the API.
  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchRates();
      _allCurrencies = result['currencies'] as List<Currency>;
      _lastUpdate = result['lastUpdate'] as String;
      _filterCurrencies();
    } on AppExceptions catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'An unexpected error occurred.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filters the currency list based on the search query.
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
