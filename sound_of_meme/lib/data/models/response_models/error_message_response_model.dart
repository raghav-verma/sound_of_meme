import 'package:json_annotation/json_annotation.dart';

part 'error_message_response_model.g.dart';

@JsonSerializable()
class ErrorMessageResponseModel {
  final String? detail;

  ErrorMessageResponseModel({
    this.detail,
  });

  factory ErrorMessageResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$ErrorMessageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageResponseModelToJson(this);
}

@JsonSerializable()
class ErrorDetailModel {
  final String type;
  final List<String> loc;
  final String msg;
  final String? input;
  final Map<String, dynamic>? ctx;

  ErrorDetailModel({
    required this.type,
    required this.loc,
    required this.msg,
    this.input,
    this.ctx,
  });

  factory ErrorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailModelToJson(this);
}

@JsonSerializable()
class ErrorListResponseModel {
  final List<ErrorDetailModel>? detail;

  ErrorListResponseModel({
    this.detail,
  });

  factory ErrorListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorListResponseModelToJson(this);
}
