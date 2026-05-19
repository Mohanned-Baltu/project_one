import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../widgets/app_card.dart';
import '../../widgets/cookly_logo.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = themeMode == ThemeMode.dark;
    final localeCode = Localizations.localeOf(context).languageCode;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          Text(
            l10n.tr('settings'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.tr('profile'),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: Row(
              children: [
                const CooklyLogo(size: 58),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.tr('guestChef'),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.tr('manageProfile'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.tr('darkMode')),
                  subtitle: Text(
                    isDark ? l10n.tr('darkMode') : l10n.tr('lightMode'),
                  ),
                  value: isDark,
                  onChanged: (value) {
                    onThemeModeChanged(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.tr('language'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'en',
                          label: Text(l10n.tr('english')),
                        ),
                        ButtonSegment(
                          value: 'ar',
                          label: Text(l10n.tr('arabic')),
                        ),
                      ],
                      selected: {localeCode},
                      onSelectionChanged: (selection) {
                        final code = selection.first;
                        onLocaleChanged(Locale(code));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.tr('aboutApp'),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.info_outline_rounded,
                    color: colorScheme.primary,
                  ),
                  title: Text(l10n.tr('aboutApp')),
                  subtitle: Text(l10n.tr('appVersion')),
                  trailing: Text(
                    '1.0.0',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: l10n.tr('appName'),
                      applicationVersion: '1.0.0',
                      children: [Text(l10n.tr('aboutCookly'))],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.tonalIcon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
            label: Text(l10n.tr('logout')),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
