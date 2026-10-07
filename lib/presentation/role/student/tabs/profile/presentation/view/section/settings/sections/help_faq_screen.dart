import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../core/model/faq_model.dart';
import '../../../../../../../../../../l10n/app_localizations.dart';
import '../widgets/faq_expansion_tile.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  String _searchQuery = '';

  List<FaqModel> _buildFaqs(AppLocalizations l10) => [
    FaqModel(
      id: '1',
      question: l10.faqResetPasswordQuestion,
      answer: l10.faqResetPasswordAnswer,
    ),
    FaqModel(
      id: '2',
      question: l10.faqDownloadMaterialsQuestion,
      answer: l10.faqDownloadMaterialsAnswer,
    ),
    FaqModel(
      id: '3',
      question: l10.faqRetakeExamQuestion,
      answer: l10.faqRetakeExamAnswer,
    ),
    FaqModel(
      id: '4',
      question: l10.faqAttendanceQuestion,
      answer: l10.faqAttendanceAnswer,
    ),
    FaqModel(
      id: '5',
      question: l10.faqSwitchLanguageQuestion,
      answer: l10.faqSwitchLanguageAnswer,
    ),
  ];

  List<FaqModel> _filterFaqs(List<FaqModel> faqs) {
    if (_searchQuery.isEmpty) return faqs;
    final query = _searchQuery.toLowerCase();
    return faqs
        .where((f) => f.question.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final faqs = _filterFaqs(_buildFaqs(l10));

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.helpCenter,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: l10.searchFaq,
                  prefixIcon: Icon(Icons.search, color: ColorManager.gray),
                  filled: true,
                  fillColor: ColorManager.gray.withValues(alpha: 0.06),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: faqs.isEmpty
                    ? Center(
                  child: CustomText(
                    text: l10.noFaqFound,
                    style: TextStyle(
                      color: ColorManager.black.withValues(alpha: 0.5),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: faqs.length,
                  itemBuilder: (context, index) =>
                      FaqExpansionTile(faq: faqs[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}