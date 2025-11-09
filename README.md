# Loan Eligibility Checker

A Flutter app to check loan eligibility based on financial profile.

## Features

- Input customer details: Name, Age, Monthly Salary, Existing EMI/Debts, Loan Amount Requested
- Validates all inputs (no empty fields, realistic values)
- Calculates Debt-to-Income Ratio (DTI)
- Checks eligibility based on:
  - DTI <= 60%
  - Age between 21 and 60
  - Loan amount <= 10x monthly salary
- Displays results in cards with green/red colors for eligibility

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
