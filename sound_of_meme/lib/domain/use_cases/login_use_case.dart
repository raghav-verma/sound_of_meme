import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class LoginUseCase extends UseCase<bool, LoginParams> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final LoginParams params) async {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
