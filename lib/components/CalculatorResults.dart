import 'package:flutter/cupertino.dart';

class CalculatorResults extends StatelessWidget {
  final String input;
  final String output;

  const CalculatorResults({super.key, required this.input, required this.output});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 30, 1, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            output.isEmpty ? '0' : output,
            style: const TextStyle(fontSize: 40),
            textAlign: TextAlign.right,
          ),
          Text(
            input.isEmpty ? '0' : input,
            style: const TextStyle(fontSize: 50),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );

  }
}
