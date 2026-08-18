import 'package:edura/core/extensions/date_ex.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:edura/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.userName, this.onTap});

  final String userName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final currentDate = DateTime.now();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: currentDate.period == "AM"
                        ? "${l10.goodMorning} 👋"
                        : "${l10.goodEvening} 👋",
                    style: TextStyle(fontSize: 16, color: ColorManager.gray),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CustomText(
                text: userName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        CircleAvatar(
          radius: 20,
          backgroundColor: ColorManager.gray.withValues(alpha: 0.2),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.notifications_on_outlined,
              color: ColorManager.black,
            ),
          ),
        ),
      ],
    );
  }
}
