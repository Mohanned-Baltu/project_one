import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'models/recipe.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/details/recipe_details_screen.dart';
import 'screens/home/home_shell.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _updateThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appName'.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: [
        ...context.localizationDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
      routes: {
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignUpScreen(),
        AppRoutes.home: (_) => HomeShell(
          themeMode: _themeMode,
          onThemeModeChanged: _updateThemeMode,
          onLocaleChanged: (locale) => context.setLocale(locale),
        ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.recipeDetails) {
          final recipe = settings.arguments;
          if (recipe is Recipe) {
            return MaterialPageRoute(
              builder: (_) => RecipeDetailsScreen(recipe: recipe),
            );
          }
        }
        return null;
      },
    );
  }
}
