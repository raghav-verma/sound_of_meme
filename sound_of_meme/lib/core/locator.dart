import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import '../data/clients/clients.dart';
import '../data/constants/constants.dart';
import '../data/data_sources/data_sources.dart';
import '../data/repository_implementation.dart';
import '../domain/repository.dart';
import '../domain/use_cases/use_cases.dart';
import '../presentation/app/app.dart';
import '../presentation/screens/screens.dart';
import '../presentation/widgets/widgets.dart';
import 'constants/constants.dart';
import 'utilities/utilities.dart';
import 'extensions/extensions.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  try {
    //Utilities
    locator.registerLazySingleton<ThemeUtility>(()=> ThemeUtility());
    locator.registerLazySingleton<NetworkUtility>(
        () => NetworkUtilityImplementation());
    locator.registerLazySingleton<RouterUtility>(
        () => RouterUtilityImplementation());
    locator.registerLazySingleton<PlatformUtility>(
        () => PlatformUtilityImplementation());
    locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

    //Local Data Sources
    final LocalDataSource localDataSource = LocalDataSourceImplementation();
    await localDataSource.init();
    locator.registerSingleton<LocalDataSource>(localDataSource);

    final logInterceptor = LogInterceptor(
      request: true,
      responseHeader: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      error: true,
      logPrint: (final object) =>
          AppConstants.showApiLogs ? object.showLogAs('API') : null,
    );

    //Dio
    final dio = Dio(
      BaseOptions(
        baseUrl: RemoteDataBaseConstants.baseUrl,
        connectTimeout: const Duration(minutes: 10),
        receiveTimeout: const Duration(minutes: 10),
      ),
    );
    locator.registerLazySingleton<Dio>(() => dio);

    dio.interceptors.add(logInterceptor);
    dio.interceptors.add(InterceptorUtility(
      localDataSource: locator(),
      dio: locator(),
    ));
    locator.registerLazySingleton(
      () => RestClient(
        dio,
      ),
    );
    locator.registerLazySingleton(
      () => MultipartClient(
        dio,
      ),
    );

    //Remote Data Sources
    locator.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImplementation(
              restClient: locator(),
              multipartClient: locator(),
            ));

    //Repositories
    locator.registerLazySingleton<Repository>(() => RepositoryImplementation(
          localDataSource: locator(),
          remoteDataSource: locator(),
          networkUtil: locator(),
          platformUtil: locator(),
          audioPlayer: locator(),
        ));

    //Use Cases
    locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
    locator
        .registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(locator()));
    locator
        .registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(locator()));
    locator.registerLazySingleton<GoogleLoginUseCase>(
        () => GoogleLoginUseCase(locator()));
    locator.registerLazySingleton<GetAllSongsUseCase>(
        () => GetAllSongsUseCase(locator()));
    locator.registerLazySingleton<GetUserSongsUseCase>(
        () => GetUserSongsUseCase(locator()));
    locator.registerLazySingleton<GetSongByIdUseCase>(
        () => GetSongByIdUseCase(locator()));
    locator.registerLazySingleton<CreateSongUseCase>(
        () => CreateSongUseCase(locator()));
    locator.registerLazySingleton<CreateCustomSongUseCase>(
        () => CreateCustomSongUseCase(locator()));
    locator.registerLazySingleton<GetUserDetailsUseCase>(
        () => GetUserDetailsUseCase(locator()));
    locator.registerLazySingleton<ViewSongUseCase>(
        () => ViewSongUseCase(locator()));
    locator.registerLazySingleton<LikeSongUseCase>(
        () => LikeSongUseCase(locator()));
    locator.registerLazySingleton<DisLikeSongUseCase>(
        () => DisLikeSongUseCase(locator()));
    locator.registerLazySingleton<CloneSongUseCase>(
        () => CloneSongUseCase(locator()));

    //Blocs
    locator.registerFactory<AppBloc>(() => AppBloc(
          loginUseCase: locator(),
          logOutUseCase: locator(),
          googleLoginUseCase: locator(),
          signUpUseCase: locator(),
          getUserDetailsUseCase: locator(),
        ));
    locator.registerFactory<HomeBloc>(() => HomeBloc(
          getAllSongsUseCase: locator(),
          getUserSongsUseCase: locator(),
          createSongUseCase: locator(),
          createCustomSongUseCase: locator(),
          cloneSongUseCase: locator(),
        ));
    locator.registerFactory<SongBloc>(() => SongBloc(
          getSongByIdUseCase: locator(),
          viewSongUseCase: locator(),
          likeSongUseCase: locator(),
          disLikeSongUseCase: locator(),
        ));
    locator.registerFactory<CurrentSongCubit>(
        () => CurrentSongCubit(audioPlayer: locator()));
  } catch (error, stack) {
    log('Locator Initialization Error $error \n$stack');
  }
}
