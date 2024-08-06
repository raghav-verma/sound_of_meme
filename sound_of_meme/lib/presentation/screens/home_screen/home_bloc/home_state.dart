part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class AllSongsLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class AllSongsErrorState extends HomeState {
  final String message;

  const AllSongsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AllSongsLoadedState extends HomeState {
  final List<SongEntity> songList;

  const AllSongsLoadedState({required this.songList});

  @override
  List<Object> get props => [songList];
}

class UserSongsLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class UserSongsErrorState extends HomeState {
  final String message;

  const UserSongsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class UserSongsLoadedState extends HomeState {
  final List<SongEntity> songList;

  const UserSongsLoadedState({required this.songList});

  @override
  List<Object> get props => [songList];
}

class CreateSongLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class CreateSongErrorState extends HomeState {
  final String message;

  const CreateSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateSongLoadedState extends HomeState {
  final SongEntity songEntity;

  const CreateSongLoadedState({required this.songEntity});

  @override
  List<Object> get props => [songEntity];
}

class CreateCustomSongLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class CreateCustomSongErrorState extends HomeState {
  final String message;

  const CreateCustomSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateCustomSongLoadedState extends HomeState {
  final SongEntity songEntity;

  const CreateCustomSongLoadedState({required this.songEntity});

  @override
  List<Object> get props => [songEntity];
}

class CloneSongLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class CloneSongErrorState extends HomeState {
  final String message;

  const CloneSongErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CloneSongLoadedState extends HomeState {
  final SongEntity songEntity;

  const CloneSongLoadedState({required this.songEntity});

  @override
  List<Object> get props => [songEntity];
}
