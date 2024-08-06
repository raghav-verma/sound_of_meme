import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/use_cases/use_cases.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllSongsUseCase _getAllSongsUseCase;
  final GetUserSongsUseCase _getUserSongsUseCase;
  final CreateSongUseCase _createSongUseCase;
  final CreateCustomSongUseCase _createCustomSongUseCase;
  final CloneSongUseCase _cloneSongUseCase;

  HomeBloc({
    required final GetAllSongsUseCase getAllSongsUseCase,
    required final GetUserSongsUseCase getUserSongsUseCase,
    required final CreateSongUseCase createSongUseCase,
    required final CreateCustomSongUseCase createCustomSongUseCase,
    required final CloneSongUseCase cloneSongUseCase,
  })  : _getAllSongsUseCase = getAllSongsUseCase,
        _getUserSongsUseCase = getUserSongsUseCase,
        _createSongUseCase = createSongUseCase,
        _createCustomSongUseCase = createCustomSongUseCase,
        _cloneSongUseCase = cloneSongUseCase,
        super(HomeInitial()) {
    on<HomeEvent>(
      (
        final HomeEvent event,
        final Emitter<HomeState> emit,
      ) async {
        if (event is GetAllSongsEvent) {
          emit.call(AllSongsLoadingState());
          final data = await _getAllSongsUseCase.call(AllSongsParams(
            page: event.page,
          ));

          await data.fold(
            (final failure) async {
              emit.call(
                AllSongsErrorState(message: failure.message),
              );
            },
            (final songList) async {
              emit.call(AllSongsLoadedState(songList: songList));
            },
          );
        } else if (event is GetUserSongsEvent) {
          emit.call(UserSongsLoadingState());
          final data = await _getUserSongsUseCase.call(UserSongsParams(
            page: event.page,
          ));

          await data.fold(
            (final failure) async {
              emit.call(
                UserSongsErrorState(message: failure.message),
              );
            },
            (final songList) async {
              emit.call(UserSongsLoadedState(songList: songList));
            },
          );
        } else if (event is CreateSongEvent) {
          emit.call(CloneSongLoadingState());
          final data =
              await _createSongUseCase.call(CreateSongParams(song: event.song));

          await data.fold(
            (final failure) async {
              emit.call(
                CreateSongErrorState(message: failure.message),
              );
            },
            (final songEntity) async {
              emit.call(CreateSongLoadedState(songEntity: songEntity));
            },
          );
        } else if (event is CreateCustomSongEvent) {
          emit.call(CreateCustomSongLoadingState());
          final data =
              await _createCustomSongUseCase.call(CreateCustomSongParams(
            title: event.title,
            lyric: event.lyric,
            genre: event.genre,
          ));

          await data.fold(
            (final failure) async {
              emit.call(
                CreateCustomSongErrorState(message: failure.message),
              );
            },
            (final songEntity) async {
              emit.call(CreateCustomSongLoadedState(songEntity: songEntity));
            },
          );
        } else if (event is CloneSongEvent) {
          emit.call(CloneSongLoadingState());
          final data = await _cloneSongUseCase.call(CloneSongParams(
            file: event.file,
            lyrics: event.lyrics,
            prompt: event.prompt,
          ));

          await data.fold(
            (final failure) async {
              emit.call(
                CloneSongErrorState(message: failure.message),
              );
            },
            (final songEntity) async {
              emit.call(CloneSongLoadedState(songEntity: songEntity));
            },
          );
        }
      },
    );
  }
}
