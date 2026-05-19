import 'package:flutter/material.dart';

class CooklyLogo extends StatelessWidget {
  const CooklyLogo({super.key, this.size = 96, this.fit = BoxFit.contain});

  final double size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final assetPath = isDark
        ? 'assets/cookly_logo_no_background_dark_mode.png'
        : 'assets/cookly_logo_no_background.png';

    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: fit,
      filterQuality: FilterQuality.high,
    );
  }
}
