// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomRequestModel _$CreateCustomRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateCustomRequestModel(
      title: json['title'] as String,
      lyric: json['lyric'] as String,
      genre: json['genere'] as String,
    );

Map<String, dynamic> _$CreateCustomRequestModelToJson(
        CreateCustomRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lyric': instance.lyric,
      'genere': instance.genre,
    };
