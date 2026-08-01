import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ExamRequirementsCard extends StatelessWidget {
  const ExamRequirementsCard({super.key, this.requirements});

  final List<String>? requirements;

  List<String> _defaultRequirements(AppLocalizations l10) => [
    l10.requirementLessons,
    l10.requirementConnection,
    l10.requirementQuietEnvironment,
  ];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final items = requirements ?? _defaultRequirements(l10);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: l10.requirements,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomText(
                        text: item,
                        style: TextStyle(
                          color: ColorManager.black.withValues(alpha: 0.75),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}