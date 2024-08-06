import 'package:json_annotation/json_annotation.dart';

part 'google_login_request_model.g.dart';

@JsonSerializable()
class GoogleLoginRequestModel {
  final String name;
  final String email;
  final String picture;

  GoogleLoginRequestModel({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory GoogleLoginRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$GoogleLoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginRequestModelToJson(this);
}
