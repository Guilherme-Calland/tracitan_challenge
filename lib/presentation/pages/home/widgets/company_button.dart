import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/app_colors.dart';
import 'package:tracitan_challenge_development/core/constants/image_paths.dart';
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
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5.0),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 26.0),
        child: Row(
          children: [
            Image.asset(ImagePaths.blocks),
            const SizedBox(width: 16.0),
            Text(
              company.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        )
      ),
    );
  }
}