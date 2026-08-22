import 'package:edura/core/model/lesson_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.lesson,
    required this.onEdit,
    required this.onDelete,
    required this.thirdActionLabel,
    required this.thirdActionIcon,
    required this.onThirdAction,
    this.thirdActionColor,
  });

  final LessonModel lesson;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final String thirdActionLabel;
  final IconData thirdActionIcon;
  final VoidCallback onThirdAction;
  final Color? thirdActionColor;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final thirdColor = thirdActionColor ?? ColorManager.salatGray;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManager.black.withValues(alpha: 0.1)),
      ),
      elevation: 0,
      color: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.network(
                      lesson.videoThumbnailUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: ColorManager.gray.withValues(alpha: 0.1),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorManager.primary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: ColorManager.primary.withValues(alpha: 0.08),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.menu_book_outlined,
                            size: 18,
                            color: ColorManager.primary.withValues(alpha: 0.6),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: lesson.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 13,
                            color: ColorManager.salatGray,
                          ),
                          const SizedBox(width: 3),
                          CustomText(
                            text: '${lesson.durationMinutes} ${l10.min}',
                            style: TextStyle(
                              color: ColorManager.salatGray,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.visibility_outlined,
                            size: 13,
                            color: ColorManager.salatGray,
                          ),
                          const SizedBox(width: 3),
                          CustomText(
                            text: '${lesson.viewCount} ${l10.views}',
                            style: TextStyle(
                              color: ColorManager.salatGray,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: ColorManager.gray.withValues(alpha: 0.15),
              height: 1,
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: Icons.edit_outlined,
                    label: l10.edit,
                    color: ColorManager.primary,
                    onTap: onEdit,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _actionButton(
                    icon: thirdActionIcon,
                    label: thirdActionLabel,
                    color: thirdColor,
                    onTap: onThirdAction,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _actionButton(
                    icon: Icons.delete_outline,
                    label: l10.delete,
                    color: ColorManager.red,
                    onTap: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 3),
            CustomText(
              text: label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
