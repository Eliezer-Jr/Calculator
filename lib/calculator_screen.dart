import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math; // Import the math library for sqrt and pow functions
import 'developer_profile.dart'; // Import the developer_profile.dart file

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _currentExpression = '';
  String _currentResult = '0';
  List<String> _history = [];

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '⌫') {
        _removeLastCharacter();
      } else if (buttonText == '^') {
        _calculateExponentiation();
      } else if (buttonText == '!') {
        _calculateFactorial();
      } else if (buttonText == '|x|') {
        _calculateAbsoluteValue();
      } else {
        _addToExpression(buttonText);
      }
      
    });
  }

  void _clear() {
    setState(() {
      _currentExpression = '';
      _currentResult = '0';
    });
  }

  void _addToExpression(String value) {
    setState(() {
      _currentExpression += value;
    });
  }

  void _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_currentExpression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      _currentResult = evalResult.toString();
      _history.add(_currentExpression);
      _currentExpression = '';
    } catch (e) {
      _currentResult = 'Error';
    }
  }

  void _removeLastCharacter() {
    setState(() {
      if (_currentExpression.isNotEmpty) {
        _currentExpression = _currentExpression.substring(0, _currentExpression.length - 1);
      }
    });
  }

  void _clearResult() {
    setState(() {
      _currentResult = '0';
    });
  }

  void _calculateExponentiation() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_currentExpression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      _currentResult = math.pow(evalResult, 2).toString();
      _history.add('$_currentExpression^2 = $_currentResult');
      _currentExpression = '';
    } catch (e) {
      _currentResult = 'Error';
    }
  }

  void _calculateFactorial() {
  try {
    Parser p = Parser();
    Expression exp = p.parse(_currentExpression);
    ContextModel cm = ContextModel();
    double evalResult = exp.evaluate(EvaluationType.REAL, cm);

    int result;
    if (evalResult < 0) {
      _currentResult = 'Invalid input';
    } else {
      result = _factorial(evalResult.toInt());
      _currentResult = result.toString();
    }

    _history.add('$_currentExpression! = $_currentResult');
    _currentExpression = '';
  } catch (e) {
    _currentResult = 'Error';
  }
}

int _factorial(int n) {
  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * _factorial(n - 1);
  }
}


  void _calculateAbsoluteValue() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_currentExpression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      _currentResult = evalResult.abs().toString();
      _history.add('|$_currentExpression| = $_currentResult');
      _currentExpression = '';
    } catch (e) {
      _currentResult = 'Error';
    }
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  void _showDeveloperInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DeveloperInfo(
          name: 'AHORLU ELIEZER MAWULI JR.', // Replace with the developer's name
          profilePictureAsset: 'lib/assets/profile.jpg', // Replace with the asset path of the profile picture
          socialMediaHandles: {
            'Snapchat': '@eliezer_jr', // Replace with the developer's snapchat handle
            'LinkedIn': 'in/eliezer-ahorlu-mawuli-jnr', // Replace with the developers LinkedIn profile URL
            'Phone': '+233 53 271 3417', // Replace with the developer's phone username
            'facebook':'eliezer_lord.jr',
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 230, 92, 92),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _showDeveloperInfo,
            tooltip: 'Developer Info',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: _buildHistory(),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _currentExpression,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _currentResult,
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildButtonRow(['7', '8', '9', '/']),
                _buildButtonRow(['4', '5', '6', '*']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['C', '0', '|x|', '+']),
                _buildButtonRow(['.', '%', '⌫']),
                _buildButtonRow(['^', '!', '=']), // Added new buttons for exponentiation, factorial, and absolute value
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonTexts) {
    return Expanded(
      child: Row(
        children: buttonTexts
            .map((buttonText) => _buildButton(buttonText))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[300],
          onPrimary: Colors.black,
          textStyle: const TextStyle(fontSize: 24.0),
        ),
        child: Text(buttonText),
      ),
    );
  }

  Widget _buildHistory() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _clearHistory,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 16.0),
                ),
                child: const Text('Clear History'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _history[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
