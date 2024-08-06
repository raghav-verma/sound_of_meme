part of 'current_song_cubit.dart';

class CurrentSongState extends Equatable {
  final SongEntity? currentSong;
  final bool isPlaying;
  final bool shuffleMode;
  final bool repeatMode;

  const CurrentSongState({
    required this.currentSong,
    this.isPlaying = false,
    this.shuffleMode = false,
    this.repeatMode = false,
  });

  CurrentSongState copyWith({
    SongEntity? currentSong,
    bool? isPlaying,
    bool? shuffleMode,
    bool? repeatMode,
  }) {
    return CurrentSongState(
      currentSong: currentSong ?? this.currentSong,
      isPlaying: isPlaying ?? this.isPlaying,
      shuffleMode: shuffleMode ?? this.shuffleMode,
      repeatMode: repeatMode ?? this.repeatMode,
    );
  }

  @override
  List<Object?> get props => [currentSong, isPlaying, shuffleMode, repeatMode];
}
