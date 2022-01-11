import 'package:abstractions/src/functional/either.dart';
import 'package:abstractions/src/functional/failure.dart';

abstract class AsyncUseCase<Out> {
  Future<Either<Failure, Out>> run();
}

abstract class FunctionalUseCase<Out> {
  Either<Failure, Out> run();
}

abstract class UseCase<Out> {
  Out run();
}
