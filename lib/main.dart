import 'package:flutter/material.dart';
import 'agreement_screen.dart';
import 'calculator_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      initialRoute: '/',
      routes: {
        '/': (context) => const AgreementScreen(),
        '/calculator': (context) =>  CalculatorScreen(),
      },
    );
  }
}
