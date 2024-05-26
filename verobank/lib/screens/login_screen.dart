import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    if (!value.contains('@')) {
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
      _emailError = _validateEmail(_usernameController.text);
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset('lib/assets/images/dollar.png'),
            ),
            SizedBox(height: 20),
            // Campo de E-mail
            TextField(
              controller: _usernameController,
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
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
