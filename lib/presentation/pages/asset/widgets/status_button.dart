import 'package:flutter/material.dart';
import 'package:tracitan_challenge_development/core/constants/app_colors.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.selected,
    required this.label,
    required this.onSelected,
    required this.iconPath,
  });

  final bool selected;
  final String label;
  final String iconPath;
  final Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : null,
          border: selected ? null : Border.all(
            color:  AppColors.grey
          ),
          borderRadius: BorderRadius.circular(3.0)
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 8.0
        ),
        child: Row(
          children: [
            Image.asset(iconPath, color: selected ? Colors.white : AppColors.darkGrey,),
            const SizedBox(width: 6.0),
            Text(label, style: TextStyle(color: selected ? Colors.white : AppColors.darkGrey),),
          ],
        ),
      ),
    );
  }
}
