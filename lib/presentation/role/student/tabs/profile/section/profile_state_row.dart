import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/stat_card.dart';
import '../../../../../../l10n/app_localizations.dart';

class ProfileStateRow extends StatelessWidget {
  const ProfileStateRow({
    super.key,
    required this.numberOfLessons,
    required this.averageScore,
    required this.rank,
    required this.points,
  });

  final int numberOfLessons;
  final int averageScore;
  final int rank;
  final int points;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: l10.lessons,
            value: numberOfLessons,
            valueColor: ColorManager.primary,
          ),
        ),
        Expanded(
          child: StatCard(
            title: l10.averageScore,
            value: averageScore,
            valueColor: ColorManager.green,
          ),
        ),
        Expanded(
          child: StatCard(
            title: l10.rank,
            value: rank,
            valueColor: ColorManager.purple,
          ),
        ),
        Expanded(
          child: StatCard(
            title: l10.points,
            value: points,
            valueColor: ColorManager.orange,
          ),
        ),
      ],
    );
  }
}
