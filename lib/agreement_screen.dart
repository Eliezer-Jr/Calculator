import 'package:flutter/material.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agreement'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please read and accept the agreement before using the calculator:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the calculator screen once the user accepts the agreement
                Navigator.pushNamed(context, '/calculator');
              },
              child: const Text('I Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
