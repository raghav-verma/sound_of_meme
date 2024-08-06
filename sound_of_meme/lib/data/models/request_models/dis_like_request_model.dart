import 'package:json_annotation/json_annotation.dart';
part 'dis_like_request_model.g.dart';

@JsonSerializable()
class DisLikeRequestModel {
  final int songId;

  DisLikeRequestModel({
    required this.songId,
  });

  factory DisLikeRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$DisLikeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DisLikeRequestModelToJson(this);

}
