import 'package:flutter/material.dart';
import 'dart:math';
import 'loan_model.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loanApplication = ModalRoute.of(context)!.settings.arguments as LoanApplication;

    // Calculate EMI for new loan (assuming 5-year loan at 12% interest)
    double calculateEMI(double principal, double rate, int tenureMonths) {
      double monthlyRate = rate / 12 / 100;
      return principal * monthlyRate * pow(1 + monthlyRate, tenureMonths) / (pow(1 + monthlyRate, tenureMonths) - 1);
    }

    double newEMI = calculateEMI(loanApplication.loanRequested, 12.0, 60); // 5 years = 60 months
    double totalEMI = loanApplication.existingEMI + newEMI;
    double dti = (totalEMI / loanApplication.salary) * 100;

    bool isEligible = dti <= 60 && loanApplication.age >= 21 && loanApplication.age <= 60 && loanApplication.loanRequested <= loanApplication.salary * 10;
    String reason = "";
    if (!isEligible) {
      if (dti > 60) reason += "DTI exceeds 60%. ";
      if (loanApplication.age < 21 || loanApplication.age > 60) reason += "Age not between 21-60. ";
      if (loanApplication.loanRequested > loanApplication.salary * 10) reason += "Loan exceeds 10x salary. ";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Eligibility Result"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Card 1 → Customer Details
              Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${loanApplication.name}"),
                      Text("Age: ${loanApplication.age}"),
                      Text("Monthly Salary: ₹${loanApplication.salary.toStringAsFixed(2)}"),
                      Text("Existing EMI/Debts: ₹${loanApplication.existingEMI.toStringAsFixed(2)}"),
                      Text("Loan Requested: ₹${loanApplication.loanRequested.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ),

              // Card 2 → Eligibility Result
              Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(
                    isEligible ? Icons.check_circle : Icons.cancel,
                    color: isEligible ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    isEligible ? "Eligible" : "Not Eligible",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isEligible ? Colors.green : Colors.red,
                    ),
                  ),
                  subtitle: isEligible
                      ? Text("Approved Amount: ₹${loanApplication.loanRequested.toStringAsFixed(2)}\nEMI: ₹${newEMI.toStringAsFixed(2)}")
                      : Text("Reason: $reason"),
                ),
              ),

              // Card 3 → DTI Info
              Card(
                elevation: 4,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Debt-to-Income Ratio: ${dti.toStringAsFixed(2)}%"),
                      Text("New EMI: ₹${newEMI.toStringAsFixed(2)}"),
                      Text("Total EMI: ₹${totalEMI.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
