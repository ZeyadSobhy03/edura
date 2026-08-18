import 'package:edura/core/model/student_detail_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/resources/routes/route_manger.dart';
import 'package:edura/core/widgets/custom_label.dart';
import 'package:edura/core/widgets/custom_text_formed_field.dart';
import 'package:edura/presentation/role/teacher/tabs/students/section/student_card.dart';
import 'package:edura/presentation/role/teacher/tabs/students/widgets/student_tab_selector.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  late final TextEditingController _searchController;
  StudentTab _currentTab = StudentTab.all;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = StudentDetailsModel(
      attendanceRecords: [],
      examResults: [],
      name: 'Ziyad',
      grade: "60",
      school: "menofia",
      averageScore: 60,
      lessons: 90,
      attendance: 99,
      lessonProgress: [],
      contactInfo: ContactInfo(
        phone: '01141935341',
        parentPhone: '01141935341',
        email: 'ziad60189@gmail.com',
      ),
    );
    final l10 = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: l10.students, fontSize: 20),
              const SizedBox(height: 8),
              CustomTextFormedField(
                controller: _searchController,
                hintText: l10.searchStudents,

                prefix: Icon(Icons.search, color: ColorManager.gray),
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              StudentTabSelector(
                currentTab: _currentTab,
                onStepTapped: (value) {
                  setState(() {
                    _currentTab = value;
                  });
                },
              ),
              StudentCard(
                student: student,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.studentDetailsScreen,
                    arguments: student
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
