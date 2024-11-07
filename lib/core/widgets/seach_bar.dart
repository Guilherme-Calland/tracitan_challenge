
import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key, required this.hint, required this.onQueryChanged, required this.controller,
  });

  final String hint;
  final Function(String) onQueryChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: () {
        const margin = 16.0;
        return const EdgeInsets.only(
          left: margin,
          right: margin,
          top: margin,
          bottom: 8.0,
        );
      }(),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: AppColors.grey,),
          hintText: hint,
          border: InputBorder.none, 
          enabledBorder: InputBorder.none, 
          focusedBorder: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.grey
          )
        ),
        onChanged: onQueryChanged,
      ),
    );
  }
}
