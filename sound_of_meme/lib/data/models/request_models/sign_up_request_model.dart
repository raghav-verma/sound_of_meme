import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  final String email;
  final String password;
  final String name;

  SignUpRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  factory SignUpRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);

}
