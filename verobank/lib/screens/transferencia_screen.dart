import 'package:flutter/material.dart';

class TransferenciaScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferência'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: 'Número da Conta'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder for transfer logic
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Transferência realizada com sucesso!'),
                ));
              },
              child: Text('Transferir'),
            ),
          ],
        ),
      ),
    );
  }
}
