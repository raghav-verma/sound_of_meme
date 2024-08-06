import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/helpers/helpers.dart';
import '../../core/extensions/extensions.dart';
import '../clients/clients.dart';
import '../models/models.dart';

abstract class RemoteDataSource {
  Future<LoginResponseModel?> login({
    required final String email,
    required final String password,
  });

  Future<SignUpResponseModel?> signUp({
    required final String email,
    required final String password,
    required final String name,
  });

  Future<SignUpResponseModel?> googleLogin({
    required final String name,
    required final String email,
    required final String picture,
  });

  Future<AllSongsResponseModel?> allSongs({
    final int? page,
  });

  Future<UserSongsResponseModel?> userSongs({
    final int? page,
  });

  Future<SongResponseModel?> getSongById({
    required final int id,
  });

  Future<SongResponseModel?> create({
    required final CreateRequestModel params,
  });

  Future<SongResponseModel?> createCustom({
    required final CreateCustomRequestModel params,
  });

  Future<UserDetailsResponseModel?> userDetails();

  Future<StatusResponseModel?> view({
    required final ViewRequestModel params,
  });

  Future<StatusResponseModel?> like({
    required final LikeRequestModel params,
  });

  Future<StatusResponseModel?> disLike({
    required final DisLikeRequestModel params,
  });

  Future<SongResponseModel?> cloneSong({
    required final File file,
    required final String prompt,
    required final String lyrics,
  });
}

class RemoteDataSourceImplementation extends RemoteDataSource {
  final RestClient restClient;
  final MultipartClient multipartClient;

  RemoteDataSourceImplementation({
    required this.restClient,
    required this.multipartClient,
  });

  @override
  Future<LoginResponseModel?> login({
    required final String email,
    required final String password,
  }) async {
    try {
      return await restClient.login(
        LoginRequestModel(
          email: email,
          password: password,
        ),
      );
    }
    // Handle Specific errors based on the Client and Backend Response Patterns:
    on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SignUpResponseModel?> signUp({
    required final String email,
    required final String password,
    required final String name,
  }) async {
    try {
      return await restClient.signUp(
        SignUpRequestModel(
          name: name,
          email: email,
          password: password,
        ),
      );
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SignUpResponseModel?> googleLogin({
    required final String name,
    required final String email,
    required final String picture,
  }) async {
    try {
      return await restClient.googleLogin(
        GoogleLoginRequestModel(
          name: name,
          email: email,
          picture: picture,
        ),
      );
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<AllSongsResponseModel?> allSongs({
    final int? page,
  }) async {
    try {
      return await restClient.allSongs(page);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<UserSongsResponseModel?> userSongs({
    final int? page,
  }) async {
    try {
      return await restClient.userSongs(page);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SongResponseModel?> getSongById({
    required final int id,
  }) async {
    try {
      return await restClient.getSongById(id);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SongResponseModel?> create({
    required final CreateRequestModel params,
  }) async {
    try {
      return await restClient.create(params);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SongResponseModel?> createCustom({
    required final CreateCustomRequestModel params,
  }) async {
    try {
      return await restClient.createCustom(params);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<UserDetailsResponseModel?> userDetails() async {
    try {
      return await restClient.userDetails();
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<StatusResponseModel?> view({
    required final ViewRequestModel params,
  }) async {
    try {
      return await restClient.view(params);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<StatusResponseModel?> like({
    required final LikeRequestModel params,
  }) async {
    try {
      return await restClient.like(params);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<StatusResponseModel?> disLike({
    required final DisLikeRequestModel params,
  }) async {
    try {
      return await restClient.disLike(params);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }

  @override
  Future<SongResponseModel?> cloneSong({
    required final File file,
    required final String prompt,
    required final String lyrics,
  }) async {
    try {
      log(file.path);
      return await multipartClient.cloneSong(file, prompt, lyrics);
    } on DioException catch (e) {
      throw RemoteServerException(e.getErrorFromDio);
    } catch (e) {
      throw RemoteParsingException(e.toString());
    }
  }
}
