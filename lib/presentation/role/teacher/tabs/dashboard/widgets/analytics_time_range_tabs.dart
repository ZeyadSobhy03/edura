import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

enum AnalyticsRange { week, month, year }

class AnalyticsTimeRangeTabs extends StatelessWidget {
  const AnalyticsTimeRangeTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final AnalyticsRange selected;
  final ValueChanged<AnalyticsRange> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final options = {
      AnalyticsRange.week: l10.week,
      AnalyticsRange.month: l10.month,
      AnalyticsRange.year: l10.year,
    };

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorManager.gray.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: options.entries.map((entry) {
          final isSelected = entry.key == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? ColorManager.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                    ),
                  ]
                      : null,
                ),
                alignment: Alignment.center,
                child: CustomText(
                  text: entry.value,
                  style: TextStyle(
                    color: isSelected ? ColorManager.primary : ColorManager.gray,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

