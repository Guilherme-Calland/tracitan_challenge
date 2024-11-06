import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key, required this.selected, required this.label, required this.onSelected,
  });

  final bool selected;
  final String label;
  final Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Padding(
        
        padding: const EdgeInsets.all(8.0),
        child: Text(label, style: TextStyle(color: selected ? Colors.green : null),),
      ),
    );
  }
}
