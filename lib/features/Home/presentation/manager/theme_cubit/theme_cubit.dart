import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/services/secure_storage_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._storageService) : super(ThemeState.initial()) {
    _loadSavedTheme();
  }
  final SecureStorageService _storageService;

  Future<void> _loadSavedTheme() async {
    final savedTheme = await _storageService.getThemeMode();
    if (savedTheme != null) {
      emit(ThemeState(themeMode: savedTheme));
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    await _storageService.saveThemeMode(themeMode);
  }

  Future<void> toggleTheme() async {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
    await _storageService.saveThemeMode(newThemeMode);
  }
}
