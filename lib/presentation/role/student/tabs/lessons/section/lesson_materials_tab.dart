import 'package:flutter/material.dart';

import '../../../../../../core/model/lesson_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'material_item_card.dart';

class LessonMaterialsTab extends StatelessWidget {
  const LessonMaterialsTab({super.key, required this.materials});

  final List<LessonMaterialModel> materials;

  @override
  Widget build(BuildContext context) {
    final l10=AppLocalizations.of(context)!;
    if (materials.isEmpty) {
      return  Center(child: Text(l10.noMaterialsFound),);
    }
    return Column(
      children: materials.map((m) => MaterialItemCard(material: m)).toList(),
    );
  }
}