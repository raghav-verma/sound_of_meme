// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponseModel _$UserDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserDetailsResponseModel(
      name: json['name'] as String,
      email: json['email'] as String,
      profileUrl: json['profile_url'] as String?,
    );

Map<String, dynamic> _$UserDetailsResponseModelToJson(
        UserDetailsResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profile_url': instance.profileUrl,
    };
