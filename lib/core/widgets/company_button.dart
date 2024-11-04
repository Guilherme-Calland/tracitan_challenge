import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key, required this.company,
    required this.onTap
  });

  final Company company;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(company.id);
      },
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        padding: const EdgeInsets.all(20),
        child: Text(company.name)
      ),
    );
  }
}