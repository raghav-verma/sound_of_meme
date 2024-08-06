import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../domain/entities/entities.dart';
import '../../../../domain/use_cases/use_cases.dart';

part 'song_event.dart';

part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetSongByIdUseCase _getSongByIdUseCase;
  final ViewSongUseCase _viewSongUseCase;
  final LikeSongUseCase _likeSongUseCase;
  final DisLikeSongUseCase _disLikeSongUseCase;

  SongBloc({
    required final GetSongByIdUseCase getSongByIdUseCase,
    required final ViewSongUseCase viewSongUseCase,
    required final LikeSongUseCase likeSongUseCase,
    required final DisLikeSongUseCase disLikeSongUseCase,
  })  : _getSongByIdUseCase = getSongByIdUseCase,
        _viewSongUseCase = viewSongUseCase,
        _likeSongUseCase = likeSongUseCase,
        _disLikeSongUseCase = disLikeSongUseCase,
        super(SongInitial()) {
    on<SongEvent>(
      (
        final SongEvent event,
        final Emitter<SongState> emit,
      ) async {
        if (event is GetSongEvent) {
          emit.call(SongLoadingState());
          final data =
              await _getSongByIdUseCase.call(GetSongByIdParams(id: event.id));

          await data.fold(
            (final failure) async {
              emit.call(
                SongErrorState(message: failure.message),
              );
            },
            (final songEntity) async {
              emit.call(SongLoadedState(songEntity: songEntity));
            },
          );
        } else if (event is ViewSongEvent) {
          emit.call(ViewSongLoadingState());
          final data =
              await _viewSongUseCase.call(ViewSongParams(songId: event.id));

          await data.fold(
            (final failure) async {
              emit.call(
                ViewSongErrorState(message: failure.message),
              );
            },
            (final isSuccessful) async {
              emit.call(ViewSongLoadedState());
            },
          );
        } else if (event is LikeSongEvent) {
          emit.call(LikeSongLoadingState());
          final data =
              await _likeSongUseCase.call(LikeSongParams(songId: event.id));

          await data.fold(
            (final failure) async {
              emit.call(
                SongErrorState(message: failure.message),
              );
            },
            (final isSuccessful) async {
              emit.call(LikeSongLoadedState());
            },
          );
        } else if (event is DisLikeSongEvent) {
          emit.call(DisLikeSongLoadingState());
          final data = await _disLikeSongUseCase
              .call(DisLikeSongParams(songId: event.id));

          await data.fold(
            (final failure) async {
              emit.call(
                DisLikeSongErrorState(message: failure.message),
              );
            },
            (final isSuccessful) async {
              emit.call(DisLikeSongLoadedState());
            },
          );
        }
      },
    );
  }
}
