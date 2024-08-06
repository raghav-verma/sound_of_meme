import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class LikeSongUseCase extends UseCase<bool, LikeSongParams> {
  final Repository _repository;

  LikeSongUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final LikeSongParams params) async {
    return _repository.like(songId: params.songId);
  }
}

class LikeSongParams {
  final int songId;

  LikeSongParams({
    required this.songId,
  });
}
