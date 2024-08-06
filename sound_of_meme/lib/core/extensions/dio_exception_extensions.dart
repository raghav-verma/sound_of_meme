import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/models.dart';
import '../constants/constants.dart';

extension DioExceptionExtensions on DioException {
  String get getErrorFromDio {
    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return StringKeyConstants.noInternet;
    }

    if (message != null && message!.isNotEmpty) {
      return message!;
    }

    if (response?.data != null) {
      if (response!.data is String) {
        return kDebugMode
            ? response!.data.toString()
            : StringKeyConstants.unknown;
      }

      if (response!.data! is Map) {
        try {
          // Handle ErrorMessageResponseModel case
          final ErrorMessageResponseModel errorMessageResult =
          ErrorMessageResponseModel.fromJson(
              response!.data as Map<String, dynamic>);
          if (errorMessageResult.detail?.isNotEmpty??false) {
            return errorMessageResult.detail!;
          }
        } on Exception {
          // Handle ErrorListResponseModel case
          try {
            final ErrorListResponseModel errorListResult =
            ErrorListResponseModel.fromJson(
                response!.data as Map<String, dynamic>);
            if (errorListResult.detail != null &&
                errorListResult.detail!.isNotEmpty) {
              return errorListResult.detail!
                  .map((error) => error.msg)
                  .join(', ');
            }
          } on Exception {
            return StringKeyConstants.unknown;
          }
        }
      }
    }

    return StringKeyConstants.unknown;
  }
}