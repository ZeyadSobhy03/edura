import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    this.onTap,
  });

  final String text;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: .06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? selectedTextColor : unselectedTextColor,
                fontWeight: FontWeight.w600,
              ),
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}