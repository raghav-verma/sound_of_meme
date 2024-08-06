import 'package:json_annotation/json_annotation.dart';

part 'user_details_response_model.g.dart';

@JsonSerializable()
class UserDetailsResponseModel {
  final String name;
  final String email;
  final String? profileUrl;

  UserDetailsResponseModel({
    required this.name,
    required this.email,
    this.profileUrl,
  });

  factory UserDetailsResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$UserDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsResponseModelToJson(this);
}