import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:edura/presentation/role/student/tabs/chat/student_chats_screen.dart';
import 'package:edura/presentation/role/student/tabs/exams/exams.dart';
import 'package:edura/presentation/role/student/tabs/home/student_home.dart';
import 'package:edura/presentation/role/student/tabs/lessons/lessons.dart';
import 'package:edura/presentation/role/student/tabs/profile/profile.dart';
import 'package:flutter/material.dart';

class StudentMainLayout extends StatefulWidget {
  const StudentMainLayout({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<StudentMainLayout> createState() => _StudentMainLayoutState();
}

class _StudentMainLayoutState extends State<StudentMainLayout> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    const List<Widget> items = [
      StudentHome(),
      Lessons(),
      Exams(),
      StudentChatsScreen(),
      Profile(),
    ];
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
            icon: const Icon(Icons.home),
            label: l10.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book),
            label: l10.lessons,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            label: l10.exams,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.messenger_outline),
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
