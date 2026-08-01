import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

enum OptionReviewState { none, correct, incorrectSelected, correctUnselected }

class AnswerOptionTile extends StatelessWidget {
  const AnswerOptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.reviewState = OptionReviewState.none,
  });

  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final OptionReviewState reviewState;

  Color get _borderColor {
    switch (reviewState) {
      case OptionReviewState.correct:
        return Colors.green;
      case OptionReviewState.incorrectSelected:
        return Colors.red;
      case OptionReviewState.correctUnselected:
        return Colors.green;
      case OptionReviewState.none:
        return isSelected
            ? ColorManager.primary
            : ColorManager.gray.withValues(alpha: 0.2);
    }
  }

  Color get _backgroundColor {
    switch (reviewState) {
      case OptionReviewState.correct:
        return Colors.green.withValues(alpha: 0.08);
      case OptionReviewState.incorrectSelected:
        return Colors.red.withValues(alpha: 0.08);
      case OptionReviewState.correctUnselected:
        return Colors.green.withValues(alpha: 0.04);
      case OptionReviewState.none:
        return isSelected
            ? ColorManager.primary.withValues(alpha: 0.06)
            : ColorManager.white;
    }
  }

  Widget? get _trailingIcon {
    switch (reviewState) {
      case OptionReviewState.correct:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case OptionReviewState.incorrectSelected:
        return const Icon(Icons.cancel, color: Colors.red, size: 20);
      case OptionReviewState.correctUnselected:
        return const Icon(Icons.check_circle_outline, color: Colors.green, size: 20);
      case OptionReviewState.none:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: ColorManager.gray.withValues(alpha: 0.12),
              child: CustomText(
                text: label,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomText(
                text: text,
                style: TextStyle(color: ColorManager.black, fontSize: 14),
              ),
            ),
            ?_trailingIcon,
          ],
        ),
      ),
    );
  }
}