part of 'song_bloc.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();
}

class GetSongEvent extends SongEvent {
  final int id;

  const GetSongEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}

class ViewSongEvent extends SongEvent {
  final int id;

  const ViewSongEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}

class LikeSongEvent extends SongEvent {
  final int id;

  const LikeSongEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}


class DisLikeSongEvent extends SongEvent {
  final int id;

  const DisLikeSongEvent({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}



