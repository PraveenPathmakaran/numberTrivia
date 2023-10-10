import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  @override
  List<Object?> get props => [];
}

class GetTrviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  const GetTrviaForConcreteNumber(this.numberString);
  @override
  List<Object?> get props => [numberString];
}

class GetTrviaForRandomNumber extends NumberTriviaEvent {}
