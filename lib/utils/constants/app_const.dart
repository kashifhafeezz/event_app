import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';

class AppConst {
  factory AppConst() => _singleton;

  AppConst._internal();

  static final AppConst _singleton = AppConst._internal();

  double screenHorizontalPadding = 20;

  bool get isArabic =>
      SupportedLanguageLocales.currentLocale ==
      SupportedLanguageLocales.arabicLocale;
}
