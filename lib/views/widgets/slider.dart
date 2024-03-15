// password_length_slider.dart
import 'package:flutter/material.dart';

class PasswordLengthSlider extends StatelessWidget {
  final double passwordLength;
  final Function(double) onChanged;

  const PasswordLengthSlider({super.key, required this.passwordLength, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 1,
      max: 20,
      divisions: 29,
      label: '$passwordLength',
      value: passwordLength.toDouble(),
      onChanged: onChanged,
    );
  }
}