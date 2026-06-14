import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: Text('dark_mode'.tr()),
                secondary: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('language'.tr()),
            trailing: DropdownButton<String>(
              value: context.locale.languageCode,
              items: [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  context.setLocale(Locale(value));
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('app_information'.tr()),
            subtitle: Text('Currency Hub v1.0.0'),
          ),
        ],
      ),
    );
  }
}
