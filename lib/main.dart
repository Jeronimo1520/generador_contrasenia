import 'package:flutter/material.dart';
import 'package:generador_contrasenia/views/widgets/generator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: Scaffold(
        body: PasswordGenerator()
      ),
    );
  }
}
