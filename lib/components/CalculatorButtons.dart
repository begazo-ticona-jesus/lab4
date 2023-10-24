// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CalculatorButtons extends StatelessWidget {
  final List<String> buttonTexts;
  final Function(String) onButtonPressed;

  const CalculatorButtons(
      {super.key, required this.buttonTexts, required this.onButtonPressed});

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
            Color buttonColor;
            if (buttonText == '=') {
              buttonColor = const Color.fromRGBO(242, 181, 176, 0.788);
            } else {
              buttonColor = const Color.fromARGB(255, 255, 255, 255);
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: SizedBox(
                width: buttonText == '=' ? 40 : 20, // Ajusta el ancho del botón
                height: 40, // Ajusta el alto del botón
                child: ElevatedButton(
                  onPressed: () {
                    onButtonPressed(buttonText);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: const CircleBorder(),
                    elevation: 5,
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 25, // Ajusta el tamaño del texto
                      color: Color.fromARGB(255, 0, 0, 0), // Establece el color del texto en blanco
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
