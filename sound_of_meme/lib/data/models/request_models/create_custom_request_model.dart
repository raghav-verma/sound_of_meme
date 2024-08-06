import 'package:json_annotation/json_annotation.dart';

part 'create_custom_request_model.g.dart';

@JsonSerializable()
class CreateCustomRequestModel {
  final String title;
  final String lyric;
  @JsonKey(name: 'genere')
  final String genre;

  CreateCustomRequestModel({
    required this.title,
    required this.lyric,
    required this.genre,
  });

  factory CreateCustomRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$CreateCustomRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCustomRequestModelToJson(this);
}
