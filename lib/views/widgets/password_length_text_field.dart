// password_length_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordLengthTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const PasswordLengthTextField({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
                          labelText: "Longitud de la contraseña",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
      onChanged: onChanged,
    );
  }
}