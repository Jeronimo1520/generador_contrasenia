// password_option_checkboxes.dart
import 'package:flutter/material.dart';

class PasswordOptionCheckboxes extends StatelessWidget {
  final bool uppercaseActivated;
  final bool lowercaseActivated;
  final bool numbersActivated;
  final bool symbolsActivated;
  final Function(bool?, String) onChanged;

  const PasswordOptionCheckboxes({super.key, 
    required this.uppercaseActivated,
    required this.lowercaseActivated,
    required this.numbersActivated,
    required this.symbolsActivated,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: const Text('Incluir mayúsculas'),
          value: uppercaseActivated,
          activeColor: Colors.red,
          onChanged: (value) => onChanged(value, 'uppercaseActivated'),
        ),
        CheckboxListTile(
          title: const Text('Incluir minúsculas'),
          value: lowercaseActivated,
          activeColor: Colors.red,
          onChanged: (value) => onChanged(value, 'lowercaseActivated'),
        ),
        CheckboxListTile(
          title: const Text('Incluir números'),
          value: numbersActivated,
          activeColor: Colors.red,
          onChanged: (value) => onChanged(value, 'numbersActivated'),
        ),
        CheckboxListTile(
          title: const Text('Incluir símbolos'),
          value: symbolsActivated,
          activeColor: Colors.red,
          onChanged: (value) => onChanged(value, 'symbolsActivated'),
        ),
      ],
    );
  }
}