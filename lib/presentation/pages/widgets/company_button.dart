import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key, required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        padding: EdgeInsets.all(20),
        child: Text('companyName')
      ),
    );
  }
}