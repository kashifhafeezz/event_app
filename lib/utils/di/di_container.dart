import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:event_app/features/auth/data/repository_implementation/auth_repository_impl.dart';
import 'package:event_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:event_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:event_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:event_app/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:event_app/features/auth/presentation/manager/register_bloc/register_bloc.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/contants/api_routes.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void manageDependencies() {
  _manageBloc();
  _manageUseCases();
  _manageRepositories();
  _manageExternalDataSources();
}

void _manageBloc() {
  di
    ..registerLazySingleton<LocaleCubit>(LocaleCubit.new)
    ..registerFactory<RegisterBloc>(() => RegisterBloc(registerUsecase: di()))
    ..registerFactory<LoginBloc>(() => LoginBloc(loginUsecase: di()));
}

void _manageUseCases() {
  di
    ..registerLazySingleton(() => RegisterUsecase(repo: di()))
    ..registerLazySingleton(() => LoginUsecase(repo: di()));
}

void _manageRepositories() {
  di
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: di()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(client: di()),
    );
}

void _manageExternalDataSources() {
  di.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: ApiRoutes().baseUrl),
  );
}
