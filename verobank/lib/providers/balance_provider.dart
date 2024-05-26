import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier {
  double _balance = 1412.00;

  double get balance => _balance;

  void subtract(double amount) {
    _balance -= amount;
    notifyListeners();
  }

  bool canSubtract(double amount) {
    return amount <= _balance;
  }
}
