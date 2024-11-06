import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/routes.dart';
import 'package:tracitan_challenge_development/domain/entities/company.dart';

class CompanyButton extends StatelessWidget {
  const CompanyButton({
    super.key, required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.assets, arguments: company.id),
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        padding: const EdgeInsets.all(20),
        child: Text(company.name)
      ),
    );
  }
}