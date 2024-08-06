import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../constants/constants.dart';
import '../models/models.dart';

part 'rest_client.g.dart';

/// Remote client for interacting with remote server
@RestApi()
abstract class RestClient {
  /// dart run build_runner build --delete-conflicting-outputs
  factory RestClient(
    final Dio dio,
  ) {
    return _RestClient(dio);
  }

  @POST(RemoteDataBaseConstants.loginEndPoint)
  Future<LoginResponseModel?> login(
    @Body() final LoginRequestModel params,
  );

  @POST(RemoteDataBaseConstants.signUpEndPoint)
  Future<SignUpResponseModel?> signUp(
    @Body() final SignUpRequestModel params,
  );

  @POST(RemoteDataBaseConstants.googleLoginEndPoint)
  Future<SignUpResponseModel?> googleLogin(
    @Body() final GoogleLoginRequestModel params,
  );

  @GET(RemoteDataBaseConstants.allSongsEndPoint)
  Future<AllSongsResponseModel?> allSongs(
    @Query(RemoteDataBaseConstants.page) final int? page,
  );

  @GET(RemoteDataBaseConstants.userSongsEndPoint)
  Future<UserSongsResponseModel?> userSongs(
    @Query(RemoteDataBaseConstants.page) final int? page,
  );

  @GET(RemoteDataBaseConstants.getSongByIdEndPoint)
  Future<SongResponseModel?> getSongById(
    @Query(RemoteDataBaseConstants.id) final int id,
  );

  @POST(RemoteDataBaseConstants.createEndPoint)
  Future<SongResponseModel?> create(
    @Body() final CreateRequestModel params,
  );

  @POST(RemoteDataBaseConstants.createCustomEndPoint)
  Future<SongResponseModel?> createCustom(
    @Body() final CreateCustomRequestModel params,
  );

  @GET(RemoteDataBaseConstants.userDetailsEndPoint)
  Future<UserDetailsResponseModel?> userDetails();

  @POST(RemoteDataBaseConstants.viewEndPoint)
  Future<StatusResponseModel?> view(
    @Body() final ViewRequestModel params,
  );

  @POST(RemoteDataBaseConstants.likeEndPoint)
  Future<StatusResponseModel?> like(
    @Body() final LikeRequestModel params,
  );

  @POST(RemoteDataBaseConstants.disLikeEndPoint)
  Future<StatusResponseModel?> disLike(
    @Body() final DisLikeRequestModel params,
  );
}

