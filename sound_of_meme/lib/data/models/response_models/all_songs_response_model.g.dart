// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_songs_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllSongsResponseModel _$AllSongsResponseModelFromJson(
        Map<String, dynamic> json) =>
    AllSongsResponseModel(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => SongResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllSongsResponseModelToJson(
        AllSongsResponseModel instance) =>
    <String, dynamic>{
      'songs': instance.songs?.map((e) => e.toJson()).toList(),
    };
