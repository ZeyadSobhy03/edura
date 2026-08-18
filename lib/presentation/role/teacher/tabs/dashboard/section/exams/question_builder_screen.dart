import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/model/question_draft_model.dart';
import '../../../../../../../l10n/app_localizations.dart';
import 'section/question_builder_card.dart';

class QuestionBuilderScreen extends StatefulWidget {
  const QuestionBuilderScreen({super.key});

  @override
  State<QuestionBuilderScreen> createState() => _QuestionBuilderScreenState();
}

class _QuestionBuilderScreenState extends State<QuestionBuilderScreen> {
  final List<QuestionDraftModel> _questions = [QuestionDraftModel()];
  bool _isPublishing = false;

  void _addQuestion() {
    setState(() => _questions.add(QuestionDraftModel()));
  }

  void _deleteQuestion(int index) {
    setState(() => _questions.removeAt(index));
  }

  bool get _allQuestionsValid => _questions.every((q) => q.isValid);

  Future<void> _publish() async {
    if (!_allQuestionsValid) {
      final l10 = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10.completeAllQuestionsBeforePublishing)),
      );
      return;
    }

    setState(() => _isPublishing = true);

    // TODO: insert _questions into Supabase `exam_questions` table,
    // linked to the exam_id this builder was opened for.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isPublishing = false);

    final l10 = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10.examPublishedSuccessfully)),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.questionBuilder,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(_questions.length, (index) {
                return QuestionBuilderCard(
                  questionNumber: index + 1,
                  draft: _questions[index],
                  onChanged: () => setState(() {}),
                  onDelete: _questions.length > 1
                      ? () => _deleteQuestion(index)
                      : null,
                );
              }),

              InkWell(
                onTap: _addQuestion,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.4),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: ColorManager.primary, size: 18),
                      const SizedBox(width: 6),
                      CustomText(
                        text: l10.addQuestion,
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isPublishing ? null : _publish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isPublishing
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    l10.publishExam(_questions.length),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}