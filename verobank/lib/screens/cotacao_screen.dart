import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    return value / _currencies[_selectedCurrency]!;
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
            TextField(
              controller: _realController,
              decoration: InputDecoration(
                labelText: 'Valor em Real',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
                _fetchCotacao();
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
              _realController.text.isNotEmpty
                  ? 'R\$ ${_realController.text} = ${_convertCurrency(double.parse(_realController.text)).toStringAsFixed(2)} ${_selectedCurrency}'
                  : _cotacao,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
