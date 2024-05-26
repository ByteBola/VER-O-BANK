import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verobank/providers/balance_provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Saldo Disponível',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Consumer<BalanceProvider>(
                    builder: (context, balanceProvider, child) {
                      return Text(
                        'R\$ ${balanceProvider.balance.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: <Widget>[
                  _buildGridItem(
                    context,
                    icon: Icons.receipt,
                    label: 'Extrato',
                    route: null, // Sem rota definida
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.compare_arrows,
                    label: 'Transferência',
                    route: '/transferencia', // Rota para Transferência
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.attach_money,
                    label: 'Cotação',
                    route: '/cotacao', // Rota para Cotação
                  ),
                  _buildGridItem(
                    context,
                    icon: Icons.qr_code,
                    label: 'Pix',
                    route: null, // Sem rota definida
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context,
      {required IconData icon, required String label, String? route}) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              icon,
              size: 40.0,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
