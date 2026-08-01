import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
    this.labelBuilder,
  });

  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;
  final String Function(String category)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;
          final displayLabel = labelBuilder?.call(category) ?? category;

          return GestureDetector(
            onTap: () => onSelected(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.gray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: displayLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : ColorManager.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}