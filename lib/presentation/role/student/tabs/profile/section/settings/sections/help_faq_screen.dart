import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/faq_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../widgets/faq_expansion_tile.dart';


class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  String _searchQuery = '';

  List<FaqModel> get _faqs => [
    FaqModel(
      id: '1',
      question: 'How do I reset my password?',
      answer:
      'Go to Settings > Change Password, or use "Forgot Password" on the login screen if you\'re signed out.',
    ),
    FaqModel(
      id: '2',
      question: 'How do I download lesson materials?',
      answer:
      'Open any lesson and go to the Materials tab. Tap the download icon next to each file.',
    ),
    FaqModel(
      id: '3',
      question: 'Can I retake an exam?',
      answer:
      'This depends on your teacher\'s settings for that exam. Check the exam details screen for retake availability.',
    ),
    FaqModel(
      id: '4',
      question: 'How is my attendance calculated?',
      answer:
      'Attendance is marked automatically when a teacher takes attendance during a live or in-person session.',
    ),
    FaqModel(
      id: '5',
      question: 'How do I switch the app language?',
      answer: 'Go to Settings > Language and choose your preferred language.',
    ),
  ];

  List<FaqModel> get _filteredFaqs {
    if (_searchQuery.isEmpty) return _faqs;
    return _faqs
        .where((f) => f.question.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final faqs = _filteredFaqs;

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