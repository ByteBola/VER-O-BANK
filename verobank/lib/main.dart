import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/cotacao_screen.dart';
import 'screens/transferencia_screen.dart';
import 'package:verobank/providers/balance_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BalanceProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/cotacao': (context) => CotacaoScreen(),
        '/transferencia': (context) => TransferenciaScreen(),
      },
    );
  }
}
