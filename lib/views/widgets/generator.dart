import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generador_contrasenia/views/widgets/password_length_text_field.dart';
import 'dart:math';
import 'slider.dart';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final TextEditingController _lengthController = TextEditingController();
  double _passwordLength = 1;

  Map<String, dynamic> values = {
    'uppercaseActivated': false,
    'lowercaseActivated': false,
    'numbersActivated': false,
    'symbolsActivated': false,
    'tipoContrasenia': false
  };

  String _generatedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generador de contraseñas"),
        backgroundColor: Colors.red,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personalice su contraseña',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: TextField(
                          readOnly:
                              false, // Para evitar que el usuario edite el campo
                          decoration: const InputDecoration(
                            labelText: "Contraseña Generada",
                            border: OutlineInputBorder(),
                          ),
                          controller:
                              TextEditingController(text: _generatedPassword),
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _copyToClipboard(); // Función para copiar la contraseña al portapapeles
                        },
                        icon: const Icon(Icons.content_copy),
                        label: const SizedBox.shrink(),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                    height:
                        15), // Añadimos un espacio entre el campo de contraseña generada y el resto de widgets
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                      PasswordLengthTextField(
                  controller: _lengthController,
                  onChanged: (String value) {
                    setState(() {
                      _passwordLength = int.parse(value).toDouble();
                      _generatedPassword = _generatePassword();
                    });
                  },
                ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: 
                      PasswordLengthSlider(
                        passwordLength: _passwordLength,
                        onChanged: (double value) {
                          setState(() {
                            _passwordLength = value.toDouble();
                            _lengthController.text = value.toInt().toString();
                            _generatedPassword = _generatePassword();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RadioListTile(
                  title: const Text("Fácil de decir"),
                  value: true,
                  groupValue: values['tipoContrasenia'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['tipoContrasenia'] = value;
                      if (values['tipoContrasenia']) {
                        values['uppercaseActivated'] = true;
                        values['lowercaseActivated'] = true;
                        values['numbersActivated'] = false;
                        values['symbolsActivated'] = false;
                        _generatedPassword =
                            _generatePassword(); // Actualizamos la contraseña generada cuando cambia el tipo
                      }
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Todos los caracteres"),
                  value: false,
                  groupValue: values['tipoContrasenia'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['tipoContrasenia'] = value;
                      if (!values['tipoContrasenia']) {
                        values['uppercaseActivated'] = true;
                        values['lowercaseActivated'] = true;
                        values['numbersActivated'] = true;
                        values['symbolsActivated'] = true;
                        _generatedPassword =
                            _generatePassword(); // Actualizamos la contraseña generada cuando cambia el tipo
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Incluir mayúsculas'),
                  value: values['uppercaseActivated'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['uppercaseActivated'] = value!;
                      _generatedPassword =
                          _generatePassword(); // Actualizamos la contraseña generada cuando cambia la configuración
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Incluir minúsculas'),
                  value: values['lowercaseActivated'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['lowercaseActivated'] = value!;
                      _generatedPassword =
                          _generatePassword(); // Actualizamos la contraseña generada cuando cambia la configuración
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Incluir números'),
                  value: values['numbersActivated'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['numbersActivated'] = value!;
                      _generatedPassword =
                          _generatePassword(); // Actualizamos la contraseña generada cuando cambia la configuración
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Incluir símbolos'),
                  value: values['symbolsActivated'],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      values['symbolsActivated'] = value!;
                      _generatedPassword =
                          _generatePassword(); // Actualizamos la contraseña generada cuando cambia la configuración
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(
        ClipboardData(text: _generatedPassword)); // Copiar al portapapeles
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contraseña copiada al portapapeles')),
    );
  }

  String _generatePassword() {
    String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    String numericChars = '0123456789';
    String symbolChars = '!@#%^&*()-_=+{}[]|;:,.<>?';

    String chars = '';

    if (values['uppercaseActivated']) chars += uppercaseChars;
    if (values['lowercaseActivated']) chars += lowercaseChars;
    if (values['numbersActivated']) chars += numericChars;
    if (values['symbolsActivated']) chars += symbolChars;

    if (chars.isEmpty) {
      return '';
    }

    Random random = Random();

    String password = '';

    for (var i = 0; i < _passwordLength; i++) {
      int randomIndex = random.nextInt(chars.length);
      password += chars[randomIndex];
    }

    return password;
  }
}
