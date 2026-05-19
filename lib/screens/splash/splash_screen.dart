import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/preferences/onboarding_prefs.dart';
import '../../widgets/cookly_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.returnToPrevious = false,
    this.duration = const Duration(seconds: 2),
  });

  final bool returnToPrevious;
  final Duration duration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(widget.duration);
    if (!mounted) return;
    final onboardingSeen = await OnboardingPrefs.isSeen();
    if (!mounted) return;
    if (widget.returnToPrevious) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.pushReplacementNamed(
      context,
      onboardingSeen ? AppRoutes.login : AppRoutes.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF8A3D), Color(0xFFFF6F3C), Color(0xFFE74C3C)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CooklyLogo(size: 210)
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .scale(
                    begin: const Offset(0.92, 0.92),
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 18),
              SvgPicture.asset(
                'assets/icons/chef_hat.svg',
                width: 34,
                height: 34,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ).animate().fadeIn(duration: 850.ms, delay: 150.ms),
            ],
          ),
        ),
      ),
    );
  }
}
