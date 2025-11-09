import 'package:flutter/material.dart';
import 'loan_model.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final salaryController = TextEditingController();
  final existingEMIController = TextEditingController();
  final loanRequestedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Eligibility Form"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Age
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your age";
                    }
                    final numValue = int.tryParse(value);
                    if (numValue == null || numValue < 21 || numValue > 60) {
                      return "Age must be between 21 and 60";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Monthly Salary
                TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Monthly Salary",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your monthly salary";
                    }
                    final numValue = double.tryParse(value);
                    if (numValue == null || numValue <= 0) {
                      return "Salary must be a valid positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Existing EMI/Debts
                TextFormField(
                  controller: existingEMIController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Existing EMI/Debts",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter existing EMI/Debts";
                    }
                    final numValue = double.tryParse(value);
                    if (numValue == null || numValue < 0) {
                      return "Enter a valid number (>=0)";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Loan Amount Requested
                TextFormField(
                  controller: loanRequestedController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Loan Amount Requested",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter loan amount requested";
                    }
                    final numValue = double.tryParse(value);
                    if (numValue == null || numValue <= 0) {
                      return "Loan amount must be a valid positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Check Eligibility"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final loanApplication = LoanApplication(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        salary: double.parse(salaryController.text),
                        existingEMI: double.parse(existingEMIController.text),
                        loanRequested: double.parse(loanRequestedController.text),
                      );

                      Navigator.pushNamed(
                        context,
                        '/result',
                        arguments: loanApplication,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
