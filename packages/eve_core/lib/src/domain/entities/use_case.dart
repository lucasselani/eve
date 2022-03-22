import 'package:eve_core/src/domain/entities/either.dart';
import 'package:eve_core/src/domain/entities/failure.dart';

typedef AsyncUseCase<Out> = Future<Either<Failure, Out>>;
typedef UseCase<Out> = Either<Failure, Out>;
