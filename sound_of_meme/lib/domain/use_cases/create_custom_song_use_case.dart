import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class CreateCustomSongUseCase extends UseCase<SongEntity, CreateCustomSongParams> {
  final Repository _repository;

  CreateCustomSongUseCase(this._repository);

  @override
  Future<Either<Failure, SongEntity>> call(final CreateCustomSongParams params) async {
    return _repository.createCustom(
      title: params.title,
      lyric: params.lyric,
      genre: params.genre,
    );
  }
}

class CreateCustomSongParams {
  final String title;
  final String lyric;
  final String genre;

  CreateCustomSongParams({
    required this.title,
    required this.lyric,
    required this.genre,
  });
}
