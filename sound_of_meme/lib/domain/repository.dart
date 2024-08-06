import 'dart:io';

import 'package:dartz/dartz.dart';
import '../core/helpers/helpers.dart';
import 'entities/entities.dart';


abstract class Repository {
  Future<Either<Failure, bool>> login({
    required final String email,
    required final String password,
  });

  Future<Either<Failure, bool>> signUp({
    required final String name,
    required final String email,
    required final String password,
  });

  Future<Either<Failure, bool>> googleLogin({
    required final String name,
    required final String email,
    required final String picture,
  });

  Future<Either<Failure, List<SongEntity>>> allSongs({
    final int? page,
  });

  Future<Either<Failure, List<SongEntity>>> userSongs({
    final int? page,
  });

  Future<Either<Failure, SongEntity>> getSongById({
    required final int id,
  });

  Future<Either<Failure, SongEntity>> create({
    required final String song,
  });

  Future<Either<Failure, SongEntity>> createCustom({
    required final String title,
    required final String lyric,
    required final String genre,
  });

  Future<Either<Failure, UserDetailsEntity>> userDetails();

  Future<Either<Failure, bool>> view({
    required final int songId,
  });

  Future<Either<Failure, bool>> like({
    required final int songId,
  });

  Future<Either<Failure, bool>> disLike({
    required final int songId,
  });

  Future<Either<Failure, SongEntity>> cloneSong({
    required final File file,
    required final String prompt,
    required final String lyrics,
  });

  Future<Either<Failure, bool>> logOut();
}


