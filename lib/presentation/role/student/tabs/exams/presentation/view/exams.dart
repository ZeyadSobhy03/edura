import 'package:edura/core/helper/localize_category.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_category_filter.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view/section/custom_exam_card.dart';
import 'package:edura/presentation/role/student/tabs/exams/presentation/view_model/exam_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/model/exam_model.dart';

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  String selectedCategory = "Available";
  String? studentId;

  @override
  void initState() {
    super.initState();
    studentId = Supabase.instance.client.auth.currentUser?.id;

    if (studentId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
      });
      return;
    }

    _reload();
  }

  void _reload() {
    final id = studentId;
    if (id == null) return;
    context.read<StudentExamCubit>().loadExams(studentId: id);
  }

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

  @override
  Widget build(BuildContext context) {
    if (studentId == null) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final l10 = AppLocalizations.of(context)!;
    final List<String> categories = [
      "Available",
      "Completed",
      "Upcoming",
      "Locked",
    ];

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
                child: BlocBuilder<StudentExamCubit, ExamState>(
                  buildWhen: (previous, current) =>
                  current is ExamInitial ||
                      current is ExamsLoading ||
                      current is ExamsLoaded ||
                      current is ExamError,
                  builder: (context, state) {
                    if (state is ExamsLoading || state is ExamInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      );
                    }

                    if (state is ExamError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorManager.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _reload,
                              child:  Text(l10.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is! ExamsLoaded) {
                      return const SizedBox.shrink();
                    }

                    final status = _categoryToStatus(selectedCategory);
                    final exams = state.exams
                        .where((e) => e.status == status)
                        .toList();

                    if (exams.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async => _reload(),
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  l10.noExamsFound,
                                  style: const TextStyle(
                                    color: ColorManager.gray,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async => _reload(),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: exams.length,
                        itemBuilder: (context, index) {
                          final exam = exams[index];
                          return CustomExamCard(
                            exam: exam,
                            onStart: exam.status == ExamStatus.available
                                ? () async {
                              await Navigator.pushNamed(
                                context,
                                RouteManger.examDetailsScreen,
                                arguments: exam,
                              );
                              if (mounted) _reload();
                            }
                                : null,
                          );
                        },
                      ),
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