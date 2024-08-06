part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAllSongsEvent extends HomeEvent {
  final int page;

  const GetAllSongsEvent({
    required this.page,
  });

  @override
  List<Object> get props => [
        page,
      ];
}

class GetUserSongsEvent extends HomeEvent {
  final int page;

  const GetUserSongsEvent({
    required this.page,
  });

  @override
  List<Object> get props => [
        page,
      ];
}

class CreateSongEvent extends HomeEvent {
  final String song;

  const CreateSongEvent({
    required this.song,
  });

  @override
  List<Object> get props => [song];
}

class CreateCustomSongEvent extends HomeEvent {
  final String title;
  final String lyric;
  final String genre;

  const CreateCustomSongEvent({
    required this.title,
    required this.lyric,
    required this.genre,
  });

  @override
  List<Object> get props => [
        title,
        lyric,
        genre,
      ];
}

class CloneSongEvent extends HomeEvent {
  final File file;
  final String prompt;
  final String lyrics;

  const CloneSongEvent({
    required this.file,
    required this.prompt,
    required this.lyrics,
  });

  @override
  List<Object> get props => [
        file,
        prompt,
        lyrics,
      ];
}
