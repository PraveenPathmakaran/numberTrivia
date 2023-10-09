import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/features/numberTrivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:numbertrivia/features/numberTrivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbertrivia/features/numberTrivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/numberTrivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/network/network_info.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    throw UnimplementedError();
  }
}
