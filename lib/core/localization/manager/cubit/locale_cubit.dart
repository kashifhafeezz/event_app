import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/localization/l10n/l10n.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
part 'locale_state.dart';

class SupportedLanguageLocales {
  static const String engLangCode = 'en';
  static const String arabicLocale = 'ar';
  static const String engLangFullName = 'English';
  static const String arabicLanguageFullName = 'Arabic';
  static String currentLocale = engLangCode;
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._storageService)
      : super(
          ToggleAppLocaleState(
            languageCode: SupportedLanguageLocales.currentLocale,
          ),
        ) {
    _loadSavedLanguage();
  }
  final SecureStorageService _storageService;

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await _storageService.getLanguage();
    if (savedLanguage != null) {
      SupportedLanguageLocales.currentLocale = savedLanguage;
      emit(ToggleAppLocaleState(languageCode: savedLanguage));
    }
  }

  Future<void> toggleApplicationLanguage({required String languageCode}) async {
    await changeLanguage(languageCode).then((_) async {
      SupportedLanguageLocales.currentLocale = languageCode;

      await _storageService.saveLanguage(languageCode);

      emit(ToggleAppLocaleState(languageCode: languageCode));
    });
  }
}
