import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:just_audio/just_audio.dart';
import '../core/helpers/helpers.dart';
import '../core/locator.dart';
import '../core/utilities/utilities.dart';
import '../domain/entities/entities.dart';
import '../domain/repository.dart';
import 'data_sources/data_sources.dart';
import 'models/models.dart';

class RepositoryImplementation implements Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkUtility networkUtil;
  final PlatformUtility platformUtil;
  final AudioPlayer audioPlayer;

  RepositoryImplementation({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkUtil,
    required this.platformUtil,
    required this.audioPlayer,
  });

  @override
  Future<Either<Failure, bool>> login({
    required final String email,
    required final String password,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.login(
          email: email,
          password: password,
        );

        if (resultModel?.accessToken != null &&
            resultModel!.accessToken.isNotEmpty) {
          await localDataSource.saveAccessToken(resultModel.accessToken);
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signUp({
    required final String name,
    required final String email,
    required final String password,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.signUp(
          name: name,
          email: email,
          password: password,
        );

        if (resultModel?.accessToken != null &&
            resultModel!.accessToken.isNotEmpty) {
          await localDataSource.saveAccessToken(resultModel.accessToken);
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> googleLogin({
    required final String name,
    required final String email,
    required final String picture,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.googleLogin(
          name: name,
          email: email,
          picture: picture,
        );

        if (resultModel?.accessToken != null &&
            resultModel!.accessToken.isNotEmpty) {
          await localDataSource.saveAccessToken(resultModel.accessToken);
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> allSongs({
    final int? page,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.allSongs(page: page);

        if (resultModel?.songs != null) {
          final songs = resultModel!.songs!.map((songModel) {
            return SongEntity.fromModel(songModel);
          }).toList();
          return Right(songs);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> userSongs({
    final int? page,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.userSongs(page: page);

        if (resultModel?.songs != null) {
          final songs = resultModel!.songs!.map((songModel) {
            return SongEntity.fromModel(songModel);
          }).toList();
          return Right(songs);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> getSongById({
    required final int id,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.getSongById(id: id);

        if (resultModel != null) {
          return Right(SongEntity.fromModel(resultModel));
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> create({
    required final String song,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.create(
          params: CreateRequestModel(song: song),
        );

        if (resultModel != null) {
          return Right(SongEntity.fromModel(resultModel));
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> createCustom({
    required final String title,
    required final String lyric,
    required final String genre,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.createCustom(
          params: CreateCustomRequestModel(
            title: title,
            lyric: lyric,
            genre: genre,
          ),
        );

        if (resultModel != null) {
          return Right(SongEntity.fromModel(resultModel));
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDetailsEntity>> userDetails() async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.userDetails();

        if (resultModel != null) {
          return Right(UserDetailsEntity.fromModel(resultModel));
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> view({
    required final int songId,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.view(
          params: ViewRequestModel(songId: songId),
        );

        if (resultModel != null) {
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> like({
    required final int songId,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.like(
          params: LikeRequestModel(songId: songId),
        );

        if (resultModel != null) {
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> disLike({
    required final int songId,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.disLike(
          params: DisLikeRequestModel(songId: songId),
        );

        if (resultModel != null) {
          return const Right(true);
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SongEntity>> cloneSong({
    required final File file,
    required final String prompt,
    required final String lyrics,
  }) async {
    try {
      if (await networkUtil.isConnected) {
        final resultModel = await remoteDataSource.cloneSong(
          file: file,
          prompt: prompt,
          lyrics: lyrics,
        );

        if (resultModel != null) {
          return Right(SongEntity.fromModel(resultModel));
        }

        return const Left(NoDataFoundFailure());
      } else {
        return const Left(NoInternetFailure());
      }
    } on DataException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(ServerFailure(e.message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      await localDataSource.clearAll();
      await audioPlayer.stop();
      return const Right(true);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      return Left(UnknownFailure(e.toString()));
    }
  }
}
