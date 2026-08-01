import 'package:edura/core/helper/localize_category.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_category_filter.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/exam_model.dart';
import 'section/custom_exam_card.dart';

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  String selectedCategory = "Available";

  ExamStatus _categoryToStatus(String category) {
    switch (category) {
      case "Available":
        return ExamStatus.available;
      case "Completed":
        return ExamStatus.completed;
      case "Upcoming":
        return ExamStatus.upcoming;
      case "Locked":
      default:
        return ExamStatus.locked;
    }
  }

  List<ExamModel> get _filteredExams {
    final status = _categoryToStatus(selectedCategory);
    return DummyExamData.all.where((e) => e.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final List<String> categories = [
      "Available",
      "Completed",
      "Upcoming",
      "Locked",
    ];
    final exams = _filteredExams;

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: l10.exams),
              const SizedBox(height: 8),
              CustomCategoryFilter(
                categories: categories,
                labelBuilder: (category) =>
                    LocalizeCategory.localizeCategory(category, context),

                selected: selectedCategory,
                onSelected: (category) =>
                    setState(() => selectedCategory = category),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: exams.isEmpty
                    ? Center(
                        child: Text(
                          l10.noExamsFound,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: exams.length,
                        itemBuilder: (context, index) {
                          final exam = exams[index];
                          return CustomExamCard(
                            exam: exam,
                            onStart: exam.status == ExamStatus.available
                                ? () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteManger.examDetailsScreen,
                                      arguments: exam,

                                    );
                                  }
                                : null,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
