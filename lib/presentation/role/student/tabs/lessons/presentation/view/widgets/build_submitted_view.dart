import 'package:flutter/material.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class BuildSubmittedView extends StatelessWidget {
  const BuildSubmittedView({super.key, this.onResubmit});

  final void Function()? onResubmit;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10.homeworkSubmitted,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onResubmit,
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(l10.resubmitHomework),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.primary,
              side: BorderSide(color: ColorManager.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
