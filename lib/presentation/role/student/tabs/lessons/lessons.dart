import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/lesson_model.dart';
import 'section/lesson_category_filter.dart';
import 'section/lesson_grid_card.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<LessonModel> get _filteredLessons {
    return DummyLessonData.all.where((lesson) {
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
    final categories = ['All', 'Mathematics', 'Physics'];

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

              LessonCategoryFilter(
                categories: categories,
                selected: _selectedCategory,
                onSelected: (category) =>
                    setState(() => _selectedCategory = category),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: _filteredLessons.isEmpty
                    ? Center(
                        child: CustomText(
                          text: l10.noLessonsFound,
                          style: TextStyle(
                            color: ColorManager.black.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: _filteredLessons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.68,
                            ),
                        itemBuilder: (context, index) {
                          final lesson = _filteredLessons[index];
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
