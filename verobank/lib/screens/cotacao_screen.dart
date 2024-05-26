import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class CotacaoScreen extends StatefulWidget {
  @override
  _CotacaoScreenState createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  String _cotacao = 'Clique em "Converter" para obter a cotação';
  TextEditingController _realController = TextEditingController();
  String _selectedCurrency = 'USD';
  Map<String, double> _currencies = {};
  bool _isLoading = false;
  String _convertedValue = '';

  Future<void> _fetchCotacao() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.hgbrasil.com/finance?format=json-cors&key=70813c46'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final currencies = data["results"]["currencies"];
      setState(() {
        _currencies = {
          'USD': currencies["USD"]["buy"],
          'EUR': currencies["EUR"]["buy"],
          'GBP': currencies["GBP"]["buy"],
        };
        _isLoading = false;
      });
    } else {
      setState(() {
        _cotacao = 'Falha ao carregar a cotação';
        _isLoading = false;
      });
    }
  }

  double _convertCurrency(double value) {
    if (_currencies.containsKey(_selectedCurrency)) {
      return value / _currencies[_selectedCurrency]!;
    } else {
      return 0.0; // Valor de fallback caso a chave não exista
    }
  }

  void _handleConversion() {
    if (_realController.text.isNotEmpty && _currencies.isNotEmpty) {
      double realValue = double.parse(_realController.text);
      double convertedValue = _convertCurrency(realValue);
      setState(() {
        _convertedValue =
            'R\$ ${_realController.text} = ${convertedValue.toStringAsFixed(2)} $_selectedCurrency';
      });
    } else {
      setState(() {
        _convertedValue = 'Por favor, insira um valor válido.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotação'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/images/budget.png',
              height: 250, // Defina a altura desejada para a logo
            ),
            SizedBox(height: 20),
            TextField(
              controller: _realController,
              decoration: InputDecoration(
                labelText: 'Valor em Real',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
              ], // Allow only digits and decimal point
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: _currencies.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_realController.text.isEmpty) {
                  setState(() {
                    _convertedValue = 'Por favor, insira um valor em Real.';
                  });
                } else {
                  _fetchCotacao().then((_) => _handleConversion());
                }
              },
              child:
                  _isLoading ? CircularProgressIndicator() : Text('Converter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _convertedValue.isNotEmpty ? _convertedValue : _cotacao,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
