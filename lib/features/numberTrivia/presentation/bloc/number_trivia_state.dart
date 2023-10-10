import 'package:equatable/equatable.dart';
import 'package:numbertrivia/features/numberTrivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  @override
  List<Object?> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  const Loaded({required this.numberTrivia});
  @override
  List<Object?> get props => [numberTrivia];
}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}