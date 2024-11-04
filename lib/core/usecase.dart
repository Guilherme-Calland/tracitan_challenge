import 'package:dartz/dartz.dart';

abstract class Usecase<T, Params> {
  Future<Either<Exception, List<T>>> call(Params params);
}

class NoParams {
  const NoParams();
}
