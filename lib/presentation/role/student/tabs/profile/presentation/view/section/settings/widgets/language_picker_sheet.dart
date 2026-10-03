import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LanguagePickerSheet extends StatelessWidget {
  const LanguagePickerSheet({
    super.key,
    required this.currentLanguageCode,
    required this.onSelected,
  });

  final String currentLanguageCode;
  final ValueChanged<String> onSelected;

  static const _languages = [
    {'code': 'en', 'label': 'English'},
    {'code': 'ar', 'label': 'العربية'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages.map((lang) {
            final isSelected = lang['code'] == currentLanguageCode;
            return ListTile(
              title: CustomText(
                text: lang['label']!,
                style: TextStyle(
                  color: ColorManager.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: ColorManager.primary)
                  : null,
              onTap: () {
                onSelected(lang['code']!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}