import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UpNextCard extends StatelessWidget {
  const UpNextCard({
    super.key,
    required this.title,
    required this.duration,
    required this.subject,
    required this.progress,
    this.onTap,
  });

  final String title;
  final int duration;
  final String subject;
  final double progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ Colors.blue.shade800,Colors.blue.shade500],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: l10.upToNextLesson,
                style: TextStyle(
                  color: ColorManager.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: title,
                style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time,
                    color: ColorManager.white.withValues(alpha: 0.7),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text: "$duration ${l10.min} ",
                    style: TextStyle(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.bar_chart,
                    color: ColorManager.white.withValues(alpha: 0.7),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text: subject,
                    style: TextStyle(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  CustomText(
                    text: l10.progress,
                    style: TextStyle(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  CustomText(
                    text: "${(progress * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      color: ColorManager.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(4),
                minHeight: 6,
                value: progress,
                backgroundColor: ColorManager.white.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100.withValues(
                      alpha: 0.9,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: ColorManager.white),
                      const SizedBox(width: 4),
                      CustomText(
                        text: l10.continueWatch,
                        style: TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
