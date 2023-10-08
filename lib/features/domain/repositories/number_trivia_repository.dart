import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/failures.dart';
import 'package:numbertrivia/features/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia();
}
