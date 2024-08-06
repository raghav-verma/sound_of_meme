import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'dart:math';
import '../../../../domain/entities/entities.dart';

part 'current_song_state.dart';

class CurrentSongCubit extends Cubit<CurrentSongState> {
  final AudioPlayer audioPlayer;
  List<SongEntity> playlist = [];
  List<SongEntity> shuffledPlaylist = [];
  int currentIndex = 0;

  CurrentSongCubit({required this.audioPlayer})
      : super(const CurrentSongState(currentSong: null));

  void setPlaylist(List<SongEntity> songs, {int startIndex = 0}) {
    playlist = songs;
    shuffledPlaylist = List.from(songs)..shuffle(Random());
    currentIndex = startIndex;
    updateSong(playlist[currentIndex]);
  }

  void updateSong(SongEntity song) async {
    await audioPlayer.pause();

    final audioSource = AudioSource.uri(
      Uri.parse(song.songUrl),
      tag: MediaItem(
        id: song.songId.toString(),
        title: song.songName,
        artist: song.userId,
        artUri: Uri.parse(song.imageUrl),
      ),
    );
    await audioPlayer.setAudioSource(audioSource);

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        if (state.repeatMode) {
          audioPlayer.seek(Duration.zero);
          audioPlayer.play();
        } else {
          nextSong();
        }
      }
    });

    audioPlayer.play();
    emit(state.copyWith(currentSong: song, isPlaying: true));
  }

  void playPause() {
    if (state.isPlaying) {
      audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      audioPlayer.play();
      emit(state.copyWith(isPlaying: true));
    }
  }

  void toggleRepeat() {
    emit(state.copyWith(repeatMode: !state.repeatMode));
  }

  void toggleShuffle() {
    emit(state.copyWith(shuffleMode: !state.shuffleMode));
    currentIndex = 0;
  }

  void seek(double val) {
    audioPlayer.seek(
      Duration(
        milliseconds: (val * audioPlayer.duration!.inMilliseconds).toInt(),
      ),
    );
  }

  void nextSong() {
    if (state.shuffleMode) {
      if (currentIndex < shuffledPlaylist.length - 1) {
        currentIndex++;
        updateSong(shuffledPlaylist[currentIndex]);
      } else {
        audioPlayer.stop();
        emit(state.copyWith(isPlaying: false, currentSong: null));
      }
    } else {
      if (currentIndex < playlist.length - 1) {
        currentIndex++;
        updateSong(playlist[currentIndex]);
      } else {
        audioPlayer.stop();
        emit(state.copyWith(isPlaying: false, currentSong: null));
      }
    }
  }

  void previousSong() {
    if (currentIndex > 0) {
      currentIndex--;
      if (state.shuffleMode) {
        updateSong(shuffledPlaylist[currentIndex]);
      } else {
        updateSong(playlist[currentIndex]);
      }
    }
  }

  AudioPlayer get getPlayer => audioPlayer;
}
