// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class CalculatorResults extends StatelessWidget {
  final String input;
  final String output;

  const CalculatorResults(
      {super.key, required this.input, required this.output});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 30, 1, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            output.isEmpty ? '0' : output,
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white
              ),
            textAlign: TextAlign.right,
          ),
          Text(
            input.isEmpty ? '0' : input,
            style: const TextStyle(
              fontSize: 45,
              color: Colors.white
              ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

}
