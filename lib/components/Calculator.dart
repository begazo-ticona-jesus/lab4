import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'CalculatorButtons.dart';
import 'CalculatorResults.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _output = '';

  final RegExp _calculatorRegex = RegExp(r'^[0-9]|[\+\-\*/]+$');

  double evalExpression(String expression) {
    if (!_calculatorRegex.hasMatch(expression)) {
      throw Exception('Invalid expression');
    } else {
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);
        return result;
      } catch (e) {
        throw Exception('Error evaluating expression: $e');
      }
    }
  }


  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '=':
          try {
            final result = evalExpression(_input);
            _output = _input;
            _input = result.toString();
          } catch (e) {
            _output = 'Error';
          }
          break;
        case 'C':
          _input = '';
          _output = '';
          break;
        default:
          _input += buttonText;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          CalculatorResults(input: _input, output: _output),
          CalculatorButtons(buttonTexts: buttonTexts, onButtonPressed: _onButtonPressed),
        ],
      ),
    );
  }
}

// Constants for the calculator button texts.
const List<String> buttonTexts = [
  '7', '8', '9', '/',
  '4', '5', '6', '*',
  '1', '2', '3', '-',
  'C', '0', '=', '+',
];
