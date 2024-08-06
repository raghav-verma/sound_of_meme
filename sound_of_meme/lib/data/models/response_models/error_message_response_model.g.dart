// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageResponseModel _$ErrorMessageResponseModelFromJson(
        Map<String, dynamic> json) =>
    ErrorMessageResponseModel(
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$ErrorMessageResponseModelToJson(
        ErrorMessageResponseModel instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

ErrorDetailModel _$ErrorDetailModelFromJson(Map<String, dynamic> json) =>
    ErrorDetailModel(
      type: json['type'] as String,
      loc: (json['loc'] as List<dynamic>).map((e) => e as String).toList(),
      msg: json['msg'] as String,
      input: json['input'] as String?,
      ctx: json['ctx'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ErrorDetailModelToJson(ErrorDetailModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'loc': instance.loc,
      'msg': instance.msg,
      'input': instance.input,
      'ctx': instance.ctx,
    };

ErrorListResponseModel _$ErrorListResponseModelFromJson(
        Map<String, dynamic> json) =>
    ErrorListResponseModel(
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => ErrorDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorListResponseModelToJson(
        ErrorListResponseModel instance) =>
    <String, dynamic>{
      'detail': instance.detail?.map((e) => e.toJson()).toList(),
    };
