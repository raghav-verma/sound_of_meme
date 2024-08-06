import 'package:json_annotation/json_annotation.dart';

part 'status_response_model.g.dart';

@JsonSerializable()
class StatusResponseModel {
  final String? status;

  StatusResponseModel({
    this.status,
  });

  factory StatusResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$StatusResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseModelToJson(this);
}
