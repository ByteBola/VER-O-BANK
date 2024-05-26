import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:verobank/providers/balance_provider.dart';

class TransferenciaScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferência'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: Image.asset('lib/assets/images/dollar.png'),
            ), // Adicionar aqui
            SizedBox(height: 20),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: 'Número da Conta'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ],
            ),
            SizedBox(height: 20),
            Consumer<BalanceProvider>(
              builder: (context, balanceProvider, child) {
                return ElevatedButton(
                  onPressed: () {
                    final amount = double.tryParse(_amountController.text);
                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Por favor, insira um valor válido.'),
                        backgroundColor: Colors.red,
                      ));
                    } else if (!balanceProvider.canSubtract(amount)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Saldo insuficiente.'),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      balanceProvider.subtract(amount);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Transferência realizada com sucesso!'),
                      ));
                      // Voltar para a tela principal
                    }
                  },
                  child: Text('Transferir'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
