import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/currency_provider.dart';
import '../widgets/currency_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Consumer<CurrencyProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search'.tr(),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                  ),
                  onChanged: provider.search,
                ),
              ),
              Expanded(
                child: provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.error != null
                        ? _buildErrorWidget(context, provider)
                        : _buildCurrencyList(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, CurrencyProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red),
          SizedBox(height: 16),
          Text('error_fetching_data'.tr()),
          Text(provider.error ?? '', textAlign: TextAlign.center),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: provider.fetchData,
            child: Text('pull_to_refresh'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyList(CurrencyProvider provider) {
    return RefreshIndicator(
      onRefresh: provider.fetchData,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 1000 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
              ),
              itemCount: provider.currencies.length,
              itemBuilder: (context, index) {
                final currency = provider.currencies[index];
                return CurrencyCard(currency: currency, lastUpdate: provider.lastUpdate);
              },
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: provider.currencies.length,
            itemBuilder: (context, index) {
              final currency = provider.currencies[index];
              return CurrencyCard(currency: currency, lastUpdate: provider.lastUpdate);
            },
          );
        },
      ),
    );
  }
}
