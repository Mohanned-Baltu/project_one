import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/currency.dart';
import '../providers/favorites_provider.dart';

class DetailsScreen extends StatefulWidget {
  final Currency currency;
  final String lastUpdate;

  const DetailsScreen({super.key, required this.currency, required this.lastUpdate});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedResult = 0.0;

  @override
  void initState() {
    super.initState();
    _amountController.text = '1';
    _calculateConversion();
  }

  void _calculateConversion() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    // API returns values where base is USD (e.g., USD -> EUR is 0.92)
    // Converted = amount * rate
    setState(() {
      _convertedResult = amount * widget.currency.rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('details'.tr()),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, provider, child) {
              bool isFav = provider.isFavorite(widget.currency.code);
              return IconButton(
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null),
                onPressed: () => provider.toggleFavorite(widget.currency),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Info
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        widget.currency.code,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.currency.name,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$1 USD = ${widget.currency.rate} ${widget.currency.code}',
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${'last_update'.tr()}: ${widget.lastUpdate}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),

            // Currency Converter
            Text(
              'currency_converter'.tr(),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: '${'amount'.tr()} (USD)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (val) => _calculateConversion(),
                    ),
                    SizedBox(height: 24),
                    Icon(Icons.arrow_downward, size: 32, color: theme.colorScheme.secondary),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text('converted_result'.tr(), style: theme.textTheme.labelLarge),
                          SizedBox(height: 8),
                          Text(
                            '${_convertedResult.toStringAsFixed(2)} ${widget.currency.code}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
