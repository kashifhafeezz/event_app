import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/localization/l10n/l10n.dart';
part 'locale_state.dart';

class SupportedLanguageLocales {
  static const String engLangCode = 'en';
  static const String arabicLocale = 'ar';
  static const String engLangFullName = 'English';
  static const String arabicLanguageFullName = 'Arabic';
  static String currentLocale = engLangCode;
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(
          ToggleAppLocaleState(
            languageCode: SupportedLanguageLocales.currentLocale,
          ),
        );

  Future<void> toggleApplicationLanguage({required String languageCode}) async {
    await changeLanguage(languageCode).then((_) async {
      emit(ToggleAppLocaleState(languageCode: languageCode));
    });
  }
}
