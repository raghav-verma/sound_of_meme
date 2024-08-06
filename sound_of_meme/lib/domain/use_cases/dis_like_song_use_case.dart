import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class DisLikeSongUseCase extends UseCase<bool, DisLikeSongParams> {
  final Repository _repository;

  DisLikeSongUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final DisLikeSongParams params) async {
    return _repository.disLike(songId: params.songId);
  }
}

class DisLikeSongParams {
  final int songId;

  DisLikeSongParams({
    required this.songId,
  });
}
