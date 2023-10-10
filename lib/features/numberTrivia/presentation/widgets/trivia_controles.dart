import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';
import '../bloc/number_trivia_event.dart';

class TriviaControlesWidget extends StatefulWidget {
  const TriviaControlesWidget({
    super.key,
  });

  @override
  State<TriviaControlesWidget> createState() => _TriviaControlesWidgetState();
}

class _TriviaControlesWidgetState extends State<TriviaControlesWidget> {
  final controller = TextEditingController();
  String? inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Input a number'),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            addConcrete();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              onPressed: addConcrete,
              child: const Text("Search"),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              onPressed: addRandom,
              child: const Text("Get random trivia"),
            )),
          ],
        )
      ],
    );
  }

  void addConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTrviaForConcreteNumber(inputStr ?? ""));
  }

  void addRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTrviaForRandomNumber());
  }
}
