import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class CreateSongUseCase extends UseCase<SongEntity, CreateSongParams> {
  final Repository _repository;

  CreateSongUseCase(this._repository);

  @override
  Future<Either<Failure, SongEntity>> call(final CreateSongParams params) async {
    return _repository.create(song: params.song);
  }
}

class CreateSongParams {
  final String song;

  CreateSongParams({
    required this.song,
  });
}
