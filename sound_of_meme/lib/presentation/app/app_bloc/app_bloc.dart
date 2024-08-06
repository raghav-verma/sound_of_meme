import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_of_meme/core/helpers/helpers.dart';
import 'package:sound_of_meme/domain/entities/entities.dart';
import '../../../../domain/use_cases/use_cases.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LoginUseCase _loginUseCase;
  final LogOutUseCase _logOutUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final GetUserDetailsUseCase _getUserDetailsUseCase;

  AppBloc({
    required final LoginUseCase loginUseCase,
    required final LogOutUseCase logOutUseCase,
    required final SignUpUseCase signUpUseCase,
    required final GoogleLoginUseCase googleLoginUseCase,
    required final GetUserDetailsUseCase getUserDetailsUseCase,
  })  : _loginUseCase = loginUseCase,
        _logOutUseCase = logOutUseCase,
        _signUpUseCase = signUpUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _getUserDetailsUseCase = getUserDetailsUseCase,
        super(AppInitial()) {
    on<AppEvent>(
      (
        final AppEvent event,
        final Emitter<AppState> emit,
      ) async {
        if (event is LogInEvent) {
          emit.call(LoginLoadingState());
          final data = await _loginUseCase.call(
            LoginParams(
              email: event.email,
              password: event.password,
            ),
          );

          await data.fold(
            (final failure) async {
              emit.call(
                LoginErrorState(message: failure.message),
              );
            },
            (final bool isSuccessful) async {
              emit.call(LoginSuccessfulState());
            },
          );
        } else if (event is LogOutEvent) {
          emit.call(LogOutLoadingState());
          final data = await _logOutUseCase.call(NoParams());

          await data.fold(
            (final failure) async {
              emit.call(
                LogOutErrorState(message: failure.message),
              );
            },
            (final bool isSuccessful) async {
              emit.call(LogOutSuccessfulState());
            },
          );
        } else if (event is SignUpEvent) {
          emit.call(SignUpLoadingState());
          final data = await _signUpUseCase.call(
            SignUpParams(
              email: event.email,
              name: event.name,
              password: event.password,
            ),
          );

          await data.fold(
            (final failure) async {
              emit.call(
                SignUpErrorState(message: failure.message),
              );
            },
            (final bool isSuccessful) async {
              emit.call(SignUpSuccessfulState());
            },
          );
        } else if (event is GoogleLoginEvent) {
          emit.call(GoogleLoginLoadingState());
          final data = await _googleLoginUseCase.call(
            GoogleLoginParams(
              email: event.email,
              name: event.name,
              picture: event.picture,
            ),
          );

          await data.fold(
            (final failure) async {
              emit.call(
                GoogleLoginErrorState(message: failure.message),
              );
            },
            (final bool isSuccessful) async {
              emit.call(GoogleLoginSuccessfulState());
            },
          );
        } else if (event is GetUserDetailsEvent) {
          emit.call(UserDetailsLoadingState());
          final data = await _getUserDetailsUseCase.call(NoParams());

          await data.fold(
            (final failure) async {
              emit.call(
                UserDetailsErrorState(message: failure.message),
              );
            },
            (final userDetailsEntity) async {
              emit.call(
                  UserDetailsLoadedState(userDetailsEntity: userDetailsEntity));
            },
          );
        }
      },
    );
  }
}
