// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'CalculatorButtons.dart';
import 'CalculatorResults.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _output = '';

  final Parser _parser = Parser();
  final ContextModel _contextModel = ContextModel();

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

  bool isOperator(String text) {
    return text == '+' || text == '-' || text == '*' || text == '/';
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '=':
          try {
            final lastChar = _input.isNotEmpty ? _input[_input.length - 1] : '';
            if (isOperator(lastChar)) {
              // Si el último carácter es un operador, quítalo antes de calcular el resultado.
              _input = _input.substring(0, _input.length - 1);
            }
            Expression exp = _parser.parse(_input);
            double result = exp.evaluate(EvaluationType.REAL, _contextModel);
            String formattedResult = result.toStringAsFixed(3);
            _output = _input;
            _input = formattedResult.toString();
          } catch (e) {
            _output = 'Error';
          }
          break;
        case 'CE':
          // Lógica para borrar un solo elemento
          if (_input.isNotEmpty) {
            _input = _input.substring(0, _input.length - 1);
          }
          break;
        case '%':
          // Lógica para convertir a porcentaje (ejemplo: 50 -> 0.5)
          if (_input.isNotEmpty) {
            final result = double.parse(_input) / 100.0;
            String formattedResult = result.toStringAsFixed(3);
            _output = _input;
            _input = formattedResult;
          }
          break;
        case 'AC':
          _input = '';
          _output = '';
          break;
        case ',':
          // Lógica para agregar un punto decimal
          if (_input.isNotEmpty) {
            final lastChar = _input[_input.length - 1];

            // Verifica si el último carácter no es una coma ni un número
            if (lastChar != '.' && !isDigit(lastChar)) {
              // Agrega una coma al final de la expresión
              _input += '0.';
            } else if (lastChar != '.') {
              // Agrega una coma al número actual
              _input += '.';
            }
          } else {
            // Si la entrada está vacía, agrega "0." para representar "0.0"
            _input = '0.';
          }
        default:
          final lastChar = _input.isNotEmpty ? _input[_input.length - 1] : '';
          if (isOperator(lastChar) && isOperator(buttonText)) {
            // Si el último carácter y el nuevo botón son operadores, reemplaza el último operador con el nuevo.
            _input = _input.substring(0, _input.length - 1);
          }
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
          Container(
            color: const Color.fromRGBO(242, 181, 176, 0.788), // Cambia esto al color de fondo que desees
            height: 160,
            width: 400,
            child: CalculatorResults(input: _input, output: _output),
          ),
          
          CalculatorButtons(buttonTexts: buttonTexts, onButtonPressed: _onButtonPressed),

        ],
      ),
    );
  }
  
  bool isDigit(String lastChar) {
    return RegExp(r'[0-9]').hasMatch(lastChar);
  }

}

// Constants for the calculator button texts.
const List<String> buttonTexts = [
  'AC', 'CE', '%', '/',
  '7', '8', '9', '*',
  '4', '5', '6', '-',
  '1', '2', '3', '+',
  ',', '0', '=',
];
