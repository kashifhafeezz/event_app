import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

Locale getLocale(String lanCode) {
  switch (lanCode) {
    case SupportedLanguageLocales.arabicLocale:
      return const Locale(SupportedLanguageLocales.arabicLocale);
    default:
      return const Locale(SupportedLanguageLocales.engLangCode);
  }
}

Future<void> changeLanguage(String languageCode) async {
  await AppLocalizations.delegate.load(getLocale(languageCode)).then((value) {
    SupportedLanguageLocales.currentLocale = languageCode;
  });
}
