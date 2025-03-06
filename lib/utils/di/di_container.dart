import 'package:event_app/core/localization/manager/cubit/locale_cubit.dart';
import 'package:event_app/core/services/secure_storage_service.dart';
import 'package:event_app/features/Home/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:event_app/features/agenda/data/datasource/agenda_remote_data_source.dart';
import 'package:event_app/features/agenda/data/datasource/agenda_remote_data_source_impl.dart';
import 'package:event_app/features/agenda/data/repository_implementation/agenda_repository_impl.dart';
import 'package:event_app/features/agenda/domain/repositories/agenda_repository.dart';
import 'package:event_app/features/agenda/domain/usecases/agenda_usecase.dart';
import 'package:event_app/features/agenda/presentation/manager/agenda_bloc/agenda_bloc.dart';
import 'package:event_app/features/ask_question/data/datasource/ask_question_remote_data_source.dart';
import 'package:event_app/features/ask_question/data/datasource/ask_question_remote_data_source_impl.dart';
import 'package:event_app/features/ask_question/data/repository_implementation/ask_question_repository_impl.dart';
import 'package:event_app/features/ask_question/domain/repositories/ask_question_repository.dart';
import 'package:event_app/features/ask_question/domain/usecases/ask_question_usecase.dart';
import 'package:event_app/features/ask_question/presentation/manager/ask_question_bloc/ask_question_bloc.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:event_app/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:event_app/features/auth/data/repository_implementation/auth_repository_impl.dart';
import 'package:event_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:event_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:event_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:event_app/features/auth/presentation/manager/login_bloc/login_bloc.dart';
import 'package:event_app/features/auth/presentation/manager/register_bloc/register_bloc.dart';
import 'package:event_app/features/speakers/data/datasource/speaker_remote_data_source.dart';
import 'package:event_app/features/speakers/data/datasource/speaker_remote_data_source_impl.dart';
import 'package:event_app/features/speakers/data/repository_implementation/speaker_repository_impl.dart';
import 'package:event_app/features/speakers/domain/repositories/speaker_repository.dart';
import 'package:event_app/features/speakers/domain/usecases/speaker_usecase.dart';
import 'package:event_app/features/speakers/presentation/manager/speaker_bloc/speaker_bloc.dart';
import 'package:event_app/utils/client/api_client.dart';
import 'package:event_app/utils/constants/api_routes.dart';
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
    ..registerLazySingleton<SecureStorageService>(SecureStorageService.new)
    ..registerFactory<LocaleCubit>(
      () => LocaleCubit(di.get<SecureStorageService>()),
    )
    ..registerFactory<ThemeCubit>(
      () => ThemeCubit(di.get<SecureStorageService>()),
    )
    ..registerFactory<RegisterBloc>(() => RegisterBloc(registerUsecase: di()))
    ..registerFactory<LoginBloc>(() => LoginBloc(loginUsecase: di()))
    ..registerFactory<SpeakerBloc>(() => SpeakerBloc(usecase: di()))
    ..registerFactory<AgendaBloc>(() => AgendaBloc(usecase: di()))
    ..registerFactory<AskQuestionBloc>(() => AskQuestionBloc(usecase: di()));
}

void _manageUseCases() {
  di
    ..registerLazySingleton(() => RegisterUsecase(repo: di()))
    ..registerLazySingleton(() => LoginUsecase(repo: di()))
    ..registerLazySingleton(() => AgendaUsecase(agendaRepository: di()))
    ..registerLazySingleton(() => SpeakerUsecase(speakerRepository: di()))
    ..registerLazySingleton(
      () => AskQuestionUsecase(askQuestionRepository: di()),
    );
}

void _manageRepositories() {
  di
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: di(),
        storageService: di(),
      ),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(client: di()),
    )
    ..registerLazySingleton<AgendaRepository>(
      () => AgendaRepositoryImpl(agendaRemoteDataSource: di()),
    )
    ..registerLazySingleton<AgendaRemoteDataSource>(
      () => AgendaRemoteDataSourceImpl(client: di()),
    )
    ..registerLazySingleton<SpeakerRepository>(
      () => SpeakerRepositoryImpl(speakerRemoteDataSource: di()),
    )
    ..registerLazySingleton<SpeakerRemoteDataSource>(
      () => SpeakerRemoteDataSourceImpl(client: di()),
    )
    ..registerLazySingleton<AskQuestionRepository>(
      () => AskQuestionRepositoryImpl(askQuestionRemoteDataSource: di()),
    )
    ..registerLazySingleton<AskQuestionRemoteDataSource>(
      () => AskQuestionRemoteDataSourceImpl(client: di()),
    );
}

void _manageExternalDataSources() {
  di.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: ApiRoutes().baseUrl),
  );
}
