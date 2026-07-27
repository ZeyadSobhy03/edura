import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/homework_model.dart';
import '../widgets/home_work_card.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key, this.homeworkList});

  final List<HomeworkModel>? homeworkList;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final items = homeworkList ?? [];

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: l10.homework,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorManager.black,
          ),
        ),
      ),
      body: items.isEmpty
          ? Center(
        child: CustomText(
          text: l10.noHomework,
          style: TextStyle(
            color: ColorManager.black.withValues(alpha: 0.5),
            fontSize: 14,
          ),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return HomeWorkCard(homework: items[index]);
        },
      ),
    );
  }
}