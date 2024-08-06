import 'package:json_annotation/json_annotation.dart';

part 'create_request_model.g.dart';

@JsonSerializable()
class CreateRequestModel {
  final String song;

  CreateRequestModel({
    required this.song,
  });

  factory CreateRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$CreateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestModelToJson(this);

}
