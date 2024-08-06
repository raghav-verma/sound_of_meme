import 'package:json_annotation/json_annotation.dart';

part 'song_response_model.g.dart';

@JsonSerializable()
class SongResponseModel {
  final int? songId;
  final String? userId;
  final String? songName;
  final String? songUrl;
  final int? likes;
  final int? views;
  final String? imageUrl;
  final String? lyrics;
  final List<String>? tags;
  final String? dateTime;

  SongResponseModel({
    this.songId,
    this.userId,
    this.songName,
    this.songUrl,
    this.likes,
    this.views,
    this.imageUrl,
    this.lyrics,
    this.tags,
    this.dateTime,
  });

  factory SongResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$SongResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongResponseModelToJson(this);
}
