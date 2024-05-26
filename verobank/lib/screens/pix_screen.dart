import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:verobank/providers/balance_provider.dart';

class PixScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PIX'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: Image.asset('lib/assets/images/logo-pix.png'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Chave (E-mail)'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _performPixTransaction(context);
              },
              child: Text('Realizar PIX'),
            ),
          ],
        ),
      ),
    );
  }

  void _performPixTransaction(BuildContext context) {
    String email = _emailController.text.trim();
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um e-mail válido.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um valor válido.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!Provider.of<BalanceProvider>(context, listen: false)
        .canSubtract(amount)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saldo insuficiente.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Provider.of<BalanceProvider>(context, listen: false).subtract(amount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Transação PIX realizada com sucesso!'),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    // Regex pattern for email validation
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }
}
