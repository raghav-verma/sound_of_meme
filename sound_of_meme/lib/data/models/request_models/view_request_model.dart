import 'package:json_annotation/json_annotation.dart';
part 'view_request_model.g.dart';

@JsonSerializable()
class ViewRequestModel {
  final int songId;

  ViewRequestModel({
    required this.songId,
  });

  factory ViewRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$ViewRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ViewRequestModelToJson(this);

}
