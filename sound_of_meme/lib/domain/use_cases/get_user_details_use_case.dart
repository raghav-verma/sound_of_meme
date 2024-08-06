import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../entities/entities.dart';
import '../repository.dart';

class GetUserDetailsUseCase extends UseCase<UserDetailsEntity, NoParams> {
  final Repository _repository;

  GetUserDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, UserDetailsEntity>> call(NoParams params) async {
    return _repository.userDetails();
  }
}
