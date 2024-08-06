part of 'song_bloc.dart';

abstract class SongState extends Equatable {
  const SongState();
}

class SongInitial extends SongState {
  @override
  List<Object> get props => [];
}

class SongLoadingState extends SongState {
  @override
  List<Object> get props => [];
}

class SongErrorState extends SongState {
  final String message;

  const SongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SongLoadedState extends SongState {
  final SongEntity songEntity;

  const SongLoadedState({required this.songEntity});

  @override
  List<Object> get props => [songEntity];
}

class ViewSongLoadingState extends SongState {
  @override
  List<Object> get props => [];
}

class ViewSongErrorState extends SongState {
  final String message;

  const ViewSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ViewSongLoadedState extends SongState {
  @override
  List<Object> get props => [];
}

class LikeSongLoadingState extends SongState {
  @override
  List<Object> get props => [];
}

class LikeSongErrorState extends SongState {
  final String message;

  const LikeSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LikeSongLoadedState extends SongState {
  @override
  List<Object> get props => [];
}

class DisLikeSongLoadingState extends SongState {
  @override
  List<Object> get props => [];
}

class DisLikeSongErrorState extends SongState {
  final String message;

  const DisLikeSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class DisLikeSongLoadedState extends SongState {
  @override
  List<Object> get props => [];
}


