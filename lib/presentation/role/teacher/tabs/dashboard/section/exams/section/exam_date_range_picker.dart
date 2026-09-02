import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class ExamDateRangePicker extends StatelessWidget {
  const ExamDateRangePicker({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;

  Future<void> _pickDate(
    BuildContext context, {
    required DateTime? initial,
    required ValueChanged<DateTime> onPicked,
    DateTime? firstDate,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primary,
              onPrimary: ColorManager.white,
              onSurface: ColorManager.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
              ),
            ),
          ),
          child: child!,
        );
      },

      context: context,
      initialDate: initial ?? now,
      firstDate: firstDate ?? now,
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) onPicked(picked);
  }

  Widget _dateField({
    required BuildContext context,
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    final l10 = AppLocalizations.of(context)!;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: ColorManager.gray.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomText(
                      text: value != null
                          ? DateFormat('MMM d, yyyy').format(value)
                          : l10.selectDate,
                      style: TextStyle(
                        color: value != null
                            ? ColorManager.black
                            : ColorManager.black.withValues(alpha: 0.4),
                        fontSize: 13,
                        fontWeight: value != null
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final hasInvalidRange =
        startDate != null && endDate != null && !endDate!.isAfter(startDate!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _dateField(
              context: context,
              label: l10.startDate,
              value: startDate,
              onTap: () => _pickDate(
                context,
                initial: startDate,
                onPicked: onStartDateChanged,
              ),
            ),
            const SizedBox(width: 12),
            _dateField(
              context: context,
              label: l10.endDate,
              value: endDate,
              onTap: () => _pickDate(
                context,
                initial: endDate,
                firstDate: startDate,
                onPicked: onEndDateChanged,
              ),
            ),
          ],
        ),
        if (hasInvalidRange) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.error_outline, size: 14, color: Colors.red),
              const SizedBox(width: 4),
              CustomText(
                text: l10.endDateMustBeAfterStartDate,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
