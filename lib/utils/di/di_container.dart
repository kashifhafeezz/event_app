import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void manageDependencies() {
  _manageBloc();
  _manageUseCases();
  _manageRepositories();
  _manageExternalDataSources();
}

void _manageBloc() {
  di.registerLazySingleton<LocaleCubit>(LocaleCubit.new);
}

void _manageUseCases() {}

void _manageRepositories() {}

void _manageExternalDataSources() {}
