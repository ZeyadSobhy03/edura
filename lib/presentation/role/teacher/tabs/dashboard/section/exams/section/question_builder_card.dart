import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:flutter/material.dart';

import '../../../data/model/question_draft_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class QuestionBuilderCard extends StatefulWidget {
  const QuestionBuilderCard({
    super.key,
    required this.questionNumber,
    required this.draft,
    required this.onChanged,
    this.onDelete,
  });

  final int questionNumber;
  final QuestionDraftModel draft;
  final VoidCallback onChanged;
  final VoidCallback? onDelete;

  @override
  State<QuestionBuilderCard> createState() => _QuestionBuilderCardState();
}

class _QuestionBuilderCardState extends State<QuestionBuilderCard> {
  late final TextEditingController _questionController;
  late final List<TextEditingController> _optionControllers;

  static const _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
      text: widget.draft.questionText,
    );
    _optionControllers = widget.draft.options
        .map((text) => TextEditingController(text: text))
        .toList();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateQuestionText(String value) {
    widget.draft.questionText = value;
    widget.onChanged();
  }

  void _updateOptionText(int index, String value) {
    widget.draft.options[index] = value;
    widget.onChanged();
  }

  void _selectCorrectOption(int index) {
    setState(() => widget.draft.correctOptionIndex = index);
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: l10.questionNumber(widget.questionNumber),
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.onDelete != null)
                InkWell(
                  onTap: widget.onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          CustomTextFormedField(
            controller: _questionController,
            onChanged: _updateQuestionText,
            maxLines: 3,
            minLines: 2,
            hintText: l10.enterYourQuestion,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),

          CustomText(
            text: l10.optionsSelectCorrectAnswer,
            style: TextStyle(
              color: ColorManager.black.withValues(alpha: 0.5),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          ...List.generate(4, (index) {
            final isCorrect = widget.draft.correctOptionIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => _selectCorrectOption(index),
                    borderRadius: BorderRadius.circular(20),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: isCorrect
                          ? Colors.green
                          : ColorManager.gray.withValues(alpha: 0.15),
                      child: isCorrect
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : CustomText(
                              text: _optionLabels[index],
                              style: TextStyle(
                                color: ColorManager.black.withValues(
                                  alpha: 0.6,
                                ),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,

                      controller: _optionControllers[index],

                      onChanged: (value) => _updateOptionText(index, value),

                      decoration: InputDecoration(
                        hintText: l10.optionHint(_optionLabels[index]),
                        filled: true,

                        fillColor: isCorrect
                            ? Colors.green.withValues(alpha: 0.06)
                            : ColorManager.gray.withValues(alpha: 0.06),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: isCorrect
                                ? Colors.green
                                : ColorManager.gray.withValues(alpha: 0.2),
                            width: isCorrect ? 1.5 : 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: isCorrect
                                ? Colors.green
                                : ColorManager.gray.withValues(alpha: 0.2),
                            width: isCorrect ? 1.5 : 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
