import 'package:dartz/dartz.dart';
import 'package:grocery_list/core/error/failure.dart'; // For Either (Failure or Success)

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {} // Use this when a UseCase doesn't need arguments