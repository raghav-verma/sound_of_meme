import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class SignUpUseCase extends UseCase<bool, SignUpParams> {
  final Repository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final SignUpParams params) async {
    return _repository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
