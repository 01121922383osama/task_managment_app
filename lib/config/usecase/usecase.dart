import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';

abstract interface class Usecase<T, P> {
  Future<Either<Failure, T>> call({required P p});
}

abstract class NoParamsUsecase<T> {
  Future<Either<Failure, T>> call();
}
