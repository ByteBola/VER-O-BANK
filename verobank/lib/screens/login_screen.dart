import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    // Expressão regular para validar e-mail
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }
    return null;
  }

  void _validateInputs() {
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, corrija os erros nos campos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 240,
              child: Image.asset('lib/assets/images/logo.png'),
            ),
            SizedBox(height: 20),
            // Campo de E-mail
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: _emailError,
              ),
              onChanged: (value) {
                setState(() {
                  _emailError = _validateEmail(value);
                });
              },
            ),
            SizedBox(height: 20),
            // Campo de Senha
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                errorText: _passwordError,
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _passwordError = _validatePassword(value);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateInputs,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Fundo azul
                foregroundColor: Colors.white, // Texto branco
                textStyle: TextStyle(
                  fontSize: 25, // Tamanho do texto maior
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Ajusta o padding
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
