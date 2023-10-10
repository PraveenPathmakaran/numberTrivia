import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/core/usecase/usecase.dart';
import 'package:numbertrivia/features/numberTrivia/presentation/bloc/number_trivia_event.dart';
import 'package:numbertrivia/features/numberTrivia/presentation/bloc/number_trivia_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/input_convertor.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTrviaForConcreteNumber>((event, emit) async {
      final Either<Failure, int> inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      inputEither.fold(
          (failure) => emit(const Error(message: invalidInputFailureMessage)),
          (integer) async {
        emit(Loading());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));

        failureOrTrivia.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (trivia) => Loaded(numberTrivia: trivia));
      });
    });

    on<GetTrviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());

      failureOrTrivia.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (trivia) => Loaded(numberTrivia: trivia));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
