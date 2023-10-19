
import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  final List<String> buttonTexts;
  final Function(String) onButtonPressed;

  const CalculatorButtons({super.key, required this.buttonTexts, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: List.generate(buttonTexts.length, (index) {
            final buttonText = buttonTexts[index];
            return TextButton(
              onPressed: () {
                onButtonPressed(buttonText);
              },
              style: TextButton.styleFrom(
                backgroundColor:  const Color(0xB6E9EAE9),
                side: const BorderSide(color: Colors.blueGrey, width: 1),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 30),
              ),
            );
          }),
        )
    );
  }
}
