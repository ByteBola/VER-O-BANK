import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cotacao');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cor de fundo do botão
                padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20), // Espaçamento interno do botão
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Borda arredondada do botão
                ),
              ),
              child: Text(
                'Cotação',
                style: TextStyle(fontSize: 18), // Tamanho do texto
              ),
            ),
            SizedBox(height: 20), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transferencia');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cor de fundo do botão
                padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20), // Espaçamento interno do botão
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Borda arredondada do botão
                ),
              ),
              child: Text(
                'Transferência',
                style: TextStyle(fontSize: 18), // Tamanho do texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
