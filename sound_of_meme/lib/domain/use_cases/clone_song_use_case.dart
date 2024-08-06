import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class CloneSongUseCase extends UseCase<SongEntity, CloneSongParams> {
  final Repository _repository;

  CloneSongUseCase(this._repository);

  @override
  Future<Either<Failure, SongEntity>> call(final CloneSongParams params) async {
    return _repository.cloneSong(
      file: params.file,
      prompt: params.prompt,
      lyrics: params.lyrics,
    );
  }
}

class CloneSongParams {
  final File file;
  final String prompt;
  final String lyrics;

  CloneSongParams({
    required this.file,
    required this.prompt,
    required this.lyrics,
  });
}
