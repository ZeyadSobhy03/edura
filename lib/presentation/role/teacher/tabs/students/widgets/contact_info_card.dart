import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/model/student_detail_model.dart';
import '../../../../../../l10n/app_localizations.dart';



class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key, required this.contactInfo});

  final ContactInfo contactInfo;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: l10.contactInfo,
            style: TextStyle(color: ColorManager.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _row(l10.phone, contactInfo.phone),
          const SizedBox(height: 10),
          _row(l10.parentPhone, contactInfo.parentPhone),
          const SizedBox(height: 10),
          _row(l10.email, contactInfo.email),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          style: TextStyle(color: ColorManager.black.withValues(alpha: 0.5), fontSize: 13),
        ),
        CustomText(
          text: value,
          style: TextStyle(color: ColorManager.black, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}