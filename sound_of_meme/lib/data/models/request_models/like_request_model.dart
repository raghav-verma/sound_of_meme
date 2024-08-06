import 'package:json_annotation/json_annotation.dart';
part 'like_request_model.g.dart';

@JsonSerializable()
class LikeRequestModel {
  final int songId;

  LikeRequestModel({
    required this.songId,
  });

  factory LikeRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$LikeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikeRequestModelToJson(this);

}
