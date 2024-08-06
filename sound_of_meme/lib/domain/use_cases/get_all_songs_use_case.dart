import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class GetAllSongsUseCase extends UseCase<List<SongEntity>, AllSongsParams> {
  final Repository _repository;

  GetAllSongsUseCase(this._repository);

  @override
  Future<Either<Failure, List<SongEntity>>> call(final AllSongsParams params) async {
    return _repository.allSongs(
      page: params.page,
    );
  }
}

class AllSongsParams {
  final int? page;

  AllSongsParams({this.page});
}
