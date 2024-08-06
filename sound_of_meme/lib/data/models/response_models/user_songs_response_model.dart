import 'package:json_annotation/json_annotation.dart';

import 'song_response_model.dart';

part 'user_songs_response_model.g.dart';

@JsonSerializable()
class UserSongsResponseModel {
  List<SongResponseModel>? songs;

  UserSongsResponseModel({
    required this.songs,
  });

  factory UserSongsResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$UserSongsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSongsResponseModelToJson(this);
}
