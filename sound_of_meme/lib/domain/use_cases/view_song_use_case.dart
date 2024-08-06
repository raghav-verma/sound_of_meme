import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class ViewSongUseCase extends UseCase<bool, ViewSongParams> {
  final Repository _repository;

  ViewSongUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final ViewSongParams params) async {
    return _repository.view(songId: params.songId);
  }
}

class ViewSongParams {
  final int songId;

  ViewSongParams({
    required this.songId,
  });
}
