import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(EMICalculatorApp());

class EMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EMICalculator(),
    );
  }
}

class EMICalculator extends StatefulWidget {
  @override
  _EMICalculatorState createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  String _emiResult = "";
  bool _isHovering = false;

  void _calculateEMI() {
    if (_formKey.currentState?.validate() ?? false) {
      double principal = double.parse(_principalController.text);
      double annualRate = double.parse(_rateController.text);
      int tenure = int.parse(_tenureController.text);

      double monthlyRate = annualRate / 12 / 100;
      int months = tenure * 12;

      double emi = principal *
          monthlyRate *
          pow((1 + monthlyRate), months) /
          (pow((1 + monthlyRate), months) - 1);

      setState(() {
        _emiResult = emi.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'EMI Calculator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _principalController,
                    decoration: InputDecoration(
                      labelText: 'Principal Amount (P)',
                      labelStyle: TextStyle(fontSize: 16),
                      filled: true,
                      fillColor: Colors.lightGreen[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the principal amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _rateController,
                    decoration: InputDecoration(
                      labelText: 'Annual Interest Rate (R) %',
                      labelStyle: TextStyle(fontSize: 16),
                      filled: true,
                      fillColor: Colors.lightGreen[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the annual interest rate';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _tenureController,
                    decoration: InputDecoration(
                      labelText: 'Loan Tenure (T) in Years',
                      labelStyle: TextStyle(fontSize: 16),
                      filled: true,
                      fillColor: Colors.lightGreen[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the loan tenure';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: MouseRegion(
                      onEnter: (event) {
                        setState(() {
                          _isHovering = true;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          _isHovering = false;
                        });
                      },
                      child: ElevatedButton(
                        onPressed: _calculateEMI,
                        child: Text(
                          'Calculate EMI',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isHovering ? Colors.white : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _isHovering ? Colors.red : Colors.grey[300],
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _formKey.currentState == null || _formKey.currentState!.validate()
                ? SizedBox.shrink()
                : Container(
                    color: Colors.red.withOpacity(0.2),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'All fields are required',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Center(
              child: Text(
                _emiResult.isEmpty ? '' : 'Your EMI is ₹ $_emiResult',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
