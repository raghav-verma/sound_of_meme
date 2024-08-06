import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class GetSongByIdUseCase extends UseCase<SongEntity, GetSongByIdParams> {
  final Repository _repository;

  GetSongByIdUseCase(this._repository);

  @override
  Future<Either<Failure, SongEntity>> call(final GetSongByIdParams params) async {
    return _repository.getSongById(id: params.id);
  }
}

class GetSongByIdParams {
  final int id;

  GetSongByIdParams({
    required this.id,
  });
}
