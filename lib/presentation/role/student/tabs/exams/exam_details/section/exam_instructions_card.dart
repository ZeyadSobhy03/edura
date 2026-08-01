
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class ExamInstructionsCard extends StatefulWidget {
  const ExamInstructionsCard({super.key, this.instructions});

  final List<String>? instructions;

  @override
  State<ExamInstructionsCard> createState() => _ExamInstructionsCardState();
}

class _ExamInstructionsCardState extends State<ExamInstructionsCard> {
  bool _isExpanded = true;

  List<String> _defaultInstructions(AppLocalizations l10) => [
    l10.instructionReadCarefully,
    l10.instructionNoGoingBack,
    l10.instructionDuration,
    l10.instructionStableConnection,
    l10.instructionAcademicHonesty,
  ];

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final items = widget.instructions ?? _defaultInstructions(l10);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    size: 16,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    text: l10.instructions,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorManager.black.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
            _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: List.generate(items.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: CustomText(
                            text: '${index + 1}',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomText(
                            text: items[index],
                            style: TextStyle(
                              color: ColorManager.black.withValues(alpha: 0.7),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}