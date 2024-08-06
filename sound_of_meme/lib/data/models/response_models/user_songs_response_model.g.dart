// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_songs_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSongsResponseModel _$UserSongsResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserSongsResponseModel(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => SongResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSongsResponseModelToJson(
        UserSongsResponseModel instance) =>
    <String, dynamic>{
      'songs': instance.songs?.map((e) => e.toJson()).toList(),
    };
