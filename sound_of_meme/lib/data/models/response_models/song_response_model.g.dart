// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongResponseModel _$SongResponseModelFromJson(Map<String, dynamic> json) =>
    SongResponseModel(
      songId: (json['song_id'] as num?)?.toInt(),
      userId: json['user_id'] as String?,
      songName: json['song_name'] as String?,
      songUrl: json['song_url'] as String?,
      likes: (json['likes'] as num?)?.toInt(),
      views: (json['views'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
      lyrics: json['lyrics'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      dateTime: json['date_time'] as String?,
    );

Map<String, dynamic> _$SongResponseModelToJson(SongResponseModel instance) =>
    <String, dynamic>{
      'song_id': instance.songId,
      'user_id': instance.userId,
      'song_name': instance.songName,
      'song_url': instance.songUrl,
      'likes': instance.likes,
      'views': instance.views,
      'image_url': instance.imageUrl,
      'lyrics': instance.lyrics,
      'tags': instance.tags,
      'date_time': instance.dateTime,
    };
