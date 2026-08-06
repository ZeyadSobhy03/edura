import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/model/note_folder_model.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'note_folder_style.dart';

class NoteFolderCard extends StatelessWidget {
  const NoteFolderCard({super.key, required this.folder, required this.onTap});

  final NoteFolderModel folder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final style = NoteFolderStyle.of(folder.icon);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(style.icon, color: style.color, size: 26),
            const SizedBox(height: 8),
            CustomText(
              text: folder.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorManager.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            CustomText(
              text: l10.notesCount(folder.notesCount),
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}