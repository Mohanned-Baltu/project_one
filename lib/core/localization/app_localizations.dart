import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  const AppLocalizations(this.context);

  final BuildContext context;

  String tr(String key) => key.tr(context: context);
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations(this);
}
