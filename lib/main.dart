import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'result_screen.dart';

void main() {
  runApp(LoanEligibilityApp());
}

class LoanEligibilityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Eligibility Checker',
      initialRoute: '/',
      routes: {
        '/': (context) => InputScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}
