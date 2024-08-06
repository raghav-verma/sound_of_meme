import 'package:equatable/equatable.dart';
import '../../data/models/models.dart';

class SongEntity extends Equatable {
  final int songId;
  final String userId;
  final String songName;
  final String songUrl;
  final int likes;
  final int views;
  final String imageUrl;
  final String lyrics;
  final List<String> tags;
  final String dateTime;

  const SongEntity({
    required this.songId,
    required this.userId,
    required this.songName,
    required this.songUrl,
    required this.likes,
    required this.views,
    required this.imageUrl,
    required this.lyrics,
    required this.tags,
    required this.dateTime,
  });

  factory SongEntity.fromModel(SongResponseModel model) => SongEntity(
    songId: model.songId ?? 0,
    userId: model.userId ?? '',
    songName: model.songName ?? '',
    songUrl: model.songUrl ?? '',
    likes: model.likes ?? 0,
    views: model.views ?? 0,
    imageUrl: model.imageUrl ?? '',
    lyrics: model.lyrics ?? '',
    tags: model.tags ?? [],
    dateTime: model.dateTime ?? '',
  );

  @override
  List<Object?> get props => [
    songId,
    userId,
    songName,
    songUrl,
    likes,
    views,
    imageUrl,
    lyrics,
    tags,
    dateTime,
  ];

  SongEntity copyWith({
    int? songId,
    String? userId,
    String? songName,
    String? songUrl,
    int? likes,
    int? views,
    String? imageUrl,
    String? lyrics,
    List<String>? tags,
    String? dateTime,
  }) {
    return SongEntity(
      songId: songId ?? this.songId,
      userId: userId ?? this.userId,
      songName: songName ?? this.songName,
      songUrl: songUrl ?? this.songUrl,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      imageUrl: imageUrl ?? this.imageUrl,
      lyrics: lyrics ?? this.lyrics,
      tags: tags ?? this.tags,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
