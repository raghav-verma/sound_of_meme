// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginRequestModel _$GoogleLoginRequestModelFromJson(
        Map<String, dynamic> json) =>
    GoogleLoginRequestModel(
      name: json['name'] as String,
      email: json['email'] as String,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$GoogleLoginRequestModelToJson(
        GoogleLoginRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'picture': instance.picture,
    };
