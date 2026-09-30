import 'dart:developer';

import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/lessons/presentation/view/section/lesson_grid_card.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view_model/lessons/teacher_lessons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/model/lesson_model.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  final String _selectedCategory = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadForStudent();
  }

  Future<void> _loadForStudent() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    final student = await Supabase.instance.client
        .from('students')
        .select('grade')
        .eq('id', userId)
        .single();

    final grade = student['grade'] as String?;
    log('Fetched student grade: $grade');
    if (grade == null || !mounted) return;

    context.read<TeacherLessonsCubit>().fetchLessonByGrade(grade);
  }

  List<LessonModel> _filter(List<LessonModel> all) {
    return all.where((lesson) {
      final matchesCategory =
          _selectedCategory == 'All' || lesson.subject == _selectedCategory;
      final matchesSearch = lesson.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: l10.lessons,
                style: TextStyle(
                  fontSize: 20,
                  color: ColorManager.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              CustomTextFormedField(
                hintText: l10.searchLessons,
                prefix: Icon(
                  Icons.search,
                  color: ColorManager.gray.withValues(alpha: 0.5),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 12),

              // CustomCategoryFilter(
              //   categories: categories,
              //   selected: _selectedCategory,
              //   onSelected: (category) =>
              //       setState(() => _selectedCategory = category),
              // ),
              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
                  builder: (context, state) {
                    if (state is TeacherLessonsLoading ||
                        state is TeacherLessonsInitial) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      );
                    }

                    if (state is TeacherLessonsFailure) {
                      return Center(
                        child: CustomText(
                          text: l10.errorOccurred,
                          style: TextStyle(color: ColorManager.red),
                        ),
                      );
                    }

                    final lessons = _filter(
                      (state as TeacherLessonsLoaded).publishedLessons,
                    );

                    if (lessons.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: l10.noLessonsFound,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      itemCount: lessons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.68,
                          ),
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];
                        return LessonGridCard(
                          lesson: lesson,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteManger.lessonDetails,
                              arguments: lesson,
                            );
                          },
                        );
                      },
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
