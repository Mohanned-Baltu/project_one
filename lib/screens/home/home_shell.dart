import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../settings/settings_screen.dart';
import 'home_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pages = [
      const HomeScreen(),
      SettingsScreen(
        themeMode: widget.themeMode,
        onThemeModeChanged: widget.onThemeModeChanged,
        onLocaleChanged: widget.onLocaleChanged,
      ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        child: KeyedSubtree(key: ValueKey(_index), child: pages[_index]),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        height: 58,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        animationDuration: const Duration(milliseconds: 260),
        items: [
          Tooltip(
            message: l10n.tr('home'),
            child: const Icon(Icons.home_rounded, color: Colors.white),
          ),
          Tooltip(
            message: l10n.tr('settings'),
            child: const Icon(Icons.settings_rounded, color: Colors.white),
          ),
        ],
        onTap: (value) => setState(() => _index = value),
      ),
    );
  }
}
