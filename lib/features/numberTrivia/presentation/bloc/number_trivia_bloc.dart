import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/features/numberTrivia/presentation/bloc/number_trivia_event.dart';
import 'package:numbertrivia/features/numberTrivia/presentation/bloc/number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {});
  }
}
