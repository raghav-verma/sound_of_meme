import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class GetUserSongsUseCase extends UseCase<List<SongEntity>, UserSongsParams> {
  final Repository _repository;

  GetUserSongsUseCase(this._repository);

  @override
  Future<Either<Failure, List<SongEntity>>> call(final UserSongsParams params) async {
    return _repository.userSongs(
      page: params.page,
    );
  }
}

class UserSongsParams {
  final int? page;

  UserSongsParams({this.page});
}
