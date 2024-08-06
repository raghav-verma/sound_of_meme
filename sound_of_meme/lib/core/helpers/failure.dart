import '../constants/constants.dart';

sealed class Failure implements Exception {
  const Failure(
    this.message,
  );

  final String message;

  @override
  String toString() => 'Failure ($runtimeType):\n$message';
}

class NoDataFoundFailure extends Failure {
  const NoDataFoundFailure() : super(StringKeyConstants.noDataFound);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super(StringKeyConstants.noInternet);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
