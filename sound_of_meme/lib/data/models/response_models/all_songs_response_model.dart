import 'package:json_annotation/json_annotation.dart';

import 'song_response_model.dart';

part 'all_songs_response_model.g.dart';

@JsonSerializable()
class AllSongsResponseModel {
  List<SongResponseModel>? songs;

  AllSongsResponseModel({
    required this.songs,
  });

  factory AllSongsResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$AllSongsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllSongsResponseModelToJson(this);
}
