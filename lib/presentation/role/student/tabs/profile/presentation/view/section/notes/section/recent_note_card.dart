import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/student_notes/note_model.dart';


class RecentNoteCard extends StatelessWidget {
  const RecentNoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  Color _subjectColor() {
    switch (note.subject.toLowerCase()) {
      case 'mathematics':
        return Colors.blue;
      case 'physics':
        return Colors.purple;
      default:
        return ColorManager.primary;
    }
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 20, color: color),
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
      splashRadius: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectColor = _subjectColor();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text: note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: DateFormat('MMM d').format(note.createdAt),
                  style: TextStyle(
                    color: ColorManager.black.withValues(alpha: 0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: subjectColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CustomText(
                    text: note.subject,
                    style: TextStyle(
                      color: subjectColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                _actionButton(
                  icon: Icons.edit_outlined,
                  color: ColorManager.primary,
                  tooltip: 'Edit',
                  onPressed: onEdit,
                ),
                const SizedBox(width: 4),
                _actionButton(
                  icon: Icons.delete_outline,
                  color: ColorManager.red,
                  tooltip: 'Delete',
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomText(
              text: note.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorManager.black.withValues(alpha: 0.6),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}