import 'package:dartz/dartz.dart';
import '../../../core/helpers/helpers.dart';
import '../repository.dart';

class LogOutUseCase extends UseCase<bool, NoParams> {
  final Repository _repository;

  LogOutUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      final NoParams params) async {
    return _repository.logOut();
  }
}

