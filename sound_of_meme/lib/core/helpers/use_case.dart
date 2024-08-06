import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(final Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class PaginationParams extends Equatable {
  final int? page;
  final int? pageSize;
  final String? filter;

  const PaginationParams({
    this.page,
    this.pageSize,
    this.filter,
  });

  @override
  List<Object> get props => [
        page ?? 0,
        pageSize ?? 10,
        filter ?? '',
      ];
}

class LocalParams extends Equatable {
  final bool fromLocal;

  const LocalParams({
    this.fromLocal = false,
  });

  @override
  List<Object> get props => [fromLocal];
}
