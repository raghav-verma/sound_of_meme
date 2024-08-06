import 'package:dartz/dartz.dart';
import '../../core/helpers/helpers.dart';
import '../repository.dart';

class GoogleLoginUseCase extends UseCase<bool, GoogleLoginParams> {
  final Repository _repository;

  GoogleLoginUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(final GoogleLoginParams params) async {
    return _repository.googleLogin(
      name: params.name,
      email: params.email,
      picture: params.picture,
    );
  }
}

class GoogleLoginParams {
  final String name;
  final String email;
  final String picture;

  GoogleLoginParams({
    required this.name,
    required this.email,
    required this.picture,
  });
}
