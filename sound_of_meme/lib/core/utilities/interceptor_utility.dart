import 'package:dio/dio.dart';

import '../../data/constants/constants.dart';
import '../../data/data_sources/data_sources.dart';

class InterceptorUtility extends QueuedInterceptorsWrapper {
  final LocalDataSource localDataSource;
  final Dio dio;

  InterceptorUtility({
    required this.localDataSource,
    required this.dio,
  });

  @override
  Future<void> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    return handler.next(await getAppendedRequestOptions(options));
  }

  Future<RequestOptions> getAppendedRequestOptions(
    final RequestOptions options,
  ) async {
    options.headers = await getRequestHeaders(
      path: options.path,
      methodType: options.method,
    );

    return options;
  }

  Future<Map<String, dynamic>> getRequestHeaders({
    required final String path,
    required final String methodType,
  }) async {
    Map<String, dynamic> headers = {};

    final String? accessToken = await localDataSource.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      headers[RemoteDataBaseConstants.authorizationHeader] =
          RemoteDataBaseConstants.authorizationBearer + accessToken;
    }

    headers[RemoteDataBaseConstants.accept] =
        RemoteDataBaseConstants.acceptValue;
    headers[RemoteDataBaseConstants.connection] =
        RemoteDataBaseConstants.connectionValue;

    return headers;
  }

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }

  @override
  Future<void> onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }
}
