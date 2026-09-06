import 'package:edura/presentation/role/teacher/tabs/dashboard/dashboard.dart';
import 'package:edura/presentation/role/teacher/tabs/students/presentation/view/students.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_chats/teacher_chats.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_lessons/presentation/view/teacher_lessons.dart';
import 'package:edura/presentation/role/teacher/tabs/teacher_profile/teacher_profile.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../l10n/app_localizations.dart';

class TeacherMainLayout extends StatefulWidget {
  const TeacherMainLayout({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<TeacherMainLayout> createState() => _TeacherMainLayoutState();
}

class _TeacherMainLayoutState extends State<TeacherMainLayout> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      Dashboard(),

      TeacherLessons(),
      Students(),
      TeacherChats(),
      TeacherProfile(),
    ];
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: ColorManager.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.gray,
        selectedLabelStyle: TextStyle(color: ColorManager.primary),
        unselectedLabelStyle: TextStyle(color: ColorManager.gray),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },

        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: l10.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_outlined),
            label: l10.lessons,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school_outlined),
            label: l10.student,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_outlined),
            label: l10.chat,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            label: l10.profile,
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,

        children: items,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
