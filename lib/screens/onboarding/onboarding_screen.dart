import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/preferences/onboarding_prefs.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _finish(BuildContext context) async {
    await OnboardingPrefs.markSeen();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showSkipButton: true,
      skip: Text(l10n.tr('skip')),
      next: const Icon(Icons.arrow_forward_rounded),
      done: Text(l10n.tr('done')),
      onDone: () => _finish(context),
      onSkip: () => _finish(context),
      dotsDecorator: DotsDecorator(
        size: const Size(8, 8),
        activeSize: const Size(24, 8),
        activeColor: colorScheme.primary,
        color: colorScheme.outlineVariant,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
      ),
      pages: [
        PageViewModel(
          title: l10n.tr('onboardingTitle1'),
          body: l10n.tr('onboardingBody1'),
          image: _OnboardingImage(
            imageUrl:
                'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=900&q=80',
          ),
          decoration: _pageDecoration(context),
        ),
        PageViewModel(
          title: l10n.tr('onboardingTitle2'),
          body: l10n.tr('onboardingBody2'),
          image: _OnboardingImage(
            imageUrl:
                'https://images.unsplash.com/photo-1514986888952-8cd320577b68?auto=format&fit=crop&w=900&q=80',
          ),
          decoration: _pageDecoration(context),
        ),
        PageViewModel(
          title: l10n.tr('onboardingTitle3'),
          body: l10n.tr('onboardingBody3'),
          image: _OnboardingImage(
            imageUrl:
                'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?auto=format&fit=crop&w=900&q=80',
          ),
          decoration: _pageDecoration(context),
        ),
      ],
    );
  }

  PageDecoration _pageDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PageDecoration(
      imagePadding: const EdgeInsets.only(top: 34),
      imageFlex: 6,
      bodyFlex: 3,
      titleTextStyle: Theme.of(
        context,
      ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800),
      bodyTextStyle: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(color: colorScheme.onSurfaceVariant),
      bodyPadding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

class _OnboardingImage extends StatelessWidget {
  const _OnboardingImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: 290,
        height: 290,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.restaurant_menu_rounded,
              size: 88,
              color: colorScheme.primary,
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.08, end: 0);
  }
}
